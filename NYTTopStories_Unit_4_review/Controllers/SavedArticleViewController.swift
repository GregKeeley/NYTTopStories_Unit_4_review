//
//  SavedArticleViewController.swift
//  NYTTopStories_Unit_4_review
//
//  Created by Gregory Keeley on 2/6/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit
import DataPersistence

class SavedArticleViewController: UIViewController {
    
public var dataPersistence: DataPersistence<Article>!
    
    private let savedArticleView = SavedArticleView()
    
    //TODO: create a saved article view
    //TODO: add a collection view to the saved article view
    //TODO: Collection view is vertical with 2 cell per row
    //TODO: Add saved view to saved view controller
    //TODO: Create an array of savedArticle = [Article]
    //TODO: reload collection view in didSave of the DatapersistenceDelegate method
    override func loadView() {
        view = savedArticleView
    }
    private var savedArticles = [Article]() {
        didSet {
            if savedArticles.isEmpty {
                savedArticleView.collectionView.backgroundView = EmptyView(title: "Saved Articles", message: "There are currently no saved articles. Start browsing by tapping on the News icon")
            } else {
                savedArticleView.collectionView.backgroundView = nil
                savedArticleView.collectionView.reloadData()
            }
            print("there are \(savedArticles.count) articles")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSavedArticles()
        savedArticleView.collectionView.dataSource = self
        savedArticleView.collectionView.delegate = self
        savedArticleView.collectionView.register(SavedArticleCell.self, forCellWithReuseIdentifier: "savedArticleCell")
        navigationItem.title = "Saved articles"
    }
    private func fetchSavedArticles() {
        do {
            savedArticles = try dataPersistence.loadItems()
        } catch {
            print("Failed to load saved articles: \(error)")
        }
    }
}
extension SavedArticleViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchSavedArticles()
    }
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("Item was deleted")
    }
}
extension SavedArticleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxwidth = (UIScreen.main.bounds.size.width)
        let adjustedWidth = (maxwidth * 0.95)
        return CGSize(width: adjustedWidth, height: (adjustedWidth / 2))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
extension SavedArticleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "savedArticleCell", for: indexPath) as? SavedArticleCell else {
            fatalError("Failed to dequeue saved article NewsCell")
        }
        let article = savedArticles.reversed()[indexPath.row]
        cell.layer.cornerRadius = 8
        cell.backgroundColor = .white
        cell.articleTitle.text = article.title
//        cell.configureCell(with: article)
        return cell
    }
    

}
