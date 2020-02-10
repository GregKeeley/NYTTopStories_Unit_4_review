//
//  NewsFeedViewController.swift
//  NYTTopStories_Unit_4_review
//
//  Created by Gregory Keeley on 2/6/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit
import DataPersistence

class NewsFeedViewController: UIViewController {
    
    public var dataPersistence: DataPersistence<Article>!
    
    private let newsFeedView = NewsFeedView()
    override func loadView() {
        view = newsFeedView
    }
    
    private var newsArticles = [Article]() {
        didSet {
            DispatchQueue.main.async {
                self.newsFeedView.collectionView.reloadData()
                print(self.newsArticles.count)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        newsFeedView.collectionView.delegate = self
        newsFeedView.collectionView.dataSource = self
        newsFeedView.collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "articleCell")
        fetchStories()
    }
    private func fetchStories(for section: String = "Technology") {
        NYTTopStoriesAPIClient.fetchTopStories(for: section) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("Failed to load articles: \(appError)")
            case .success(let articles):
                self?.newsArticles = articles
            }
            
        }
    }
    
    
}
extension NewsFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? NewsCell else {
            fatalError("Could not downcast to NewsCell")
        }
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        cell.insetsLayoutMarginsFromSafeArea = true
        let article = newsArticles[indexPath.row]
        cell.configureCell(with: article)
        return cell
    }
    
    
}
extension NewsFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let maxwidth = (UIScreen.main.bounds.size.width)
            let adjustedWidth = (maxwidth * 0.95)
            return CGSize(width: adjustedWidth, height: (adjustedWidth / 2))
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = newsArticles[indexPath.row]
        let articleDetailVC = ArticleDetailViewController()
        
        articleDetailVC.article = article
        articleDetailVC.dataPersistence = dataPersistence
        navigationController?.pushViewController(articleDetailVC, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
