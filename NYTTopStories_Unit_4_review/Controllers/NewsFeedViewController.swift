//
//  NewsFeedViewController.swift
//  NYTTopStories_Unit_4_review
//
//  Created by Gregory Keeley on 2/6/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
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
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.20
        return CGSize(width: itemWidth, height: itemHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = newsArticles[indexPath.row]
        let articleDetailVC = ArticleDetailViewController()
        articleDetailVC.article = article
        navigationController?.pushViewController(articleDetailVC, animated: true)
        
    }
}
