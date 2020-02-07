//
//  ArticleDetailViewController.swift
//  NYTTopStories_Unit_4_review
//
//  Created by Gregory Keeley on 2/7/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit
import ImageKit

class ArticleDetailViewController: UIViewController {

    public var article: Article?
    private let detailView = ArticleDetailView()
    override func loadView() {
        view = detailView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        updateUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveArticleButtonPressed(_:)))
    }
    @objc func saveArticleButtonPressed(_ sender: UIBarButtonItem) {
        print("saved article")
    }
    private func updateUI() {
        guard let article = article else {
            fatalError("Did not load article")
        }
        navigationItem.title = article.title
        detailView.articleHeadline.text = article.abstract
        detailView.articleImage.getImage(with: article.getArticleImageURL(for: .superJumbo)) { [weak self] (result) in
            switch result {
            case .failure:
                print("Failed to load image")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailView.articleImage.image = image
                }
            }
        }
    }
}
