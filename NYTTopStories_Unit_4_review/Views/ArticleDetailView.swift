//
//  ArticleDetailView.swift
//  NYTTopStories_Unit_4_review
//
//  Created by Gregory Keeley on 2/7/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class ArticleDetailView: UIView {
    public lazy var articleImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.backgroundColor = .green
        image.contentMode = .scaleAspectFill
        return image
    }()
    public lazy var articleHeadline: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Article headline"
        return label
    }()
    public lazy var abstractLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Abstract"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        articleImageSetupConstraints()
        abstractLabelContraintSetup()
        articleHeadlineSetupConstraints()
    }
    private func articleImageSetupConstraints() {
        addSubview(articleImage)
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            articleImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            articleImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            articleImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            articleImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40)
            
        ])
    }
    private func abstractLabelContraintSetup() {
        addSubview(abstractLabel)
        abstractLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            abstractLabel.topAnchor.constraint(equalTo: articleImage.bottomAnchor, constant: 8),
            abstractLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            abstractLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            
        ])
    }
    private func articleHeadlineSetupConstraints() {
        addSubview(articleHeadline)
        articleHeadline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            articleHeadline.topAnchor.constraint(equalTo: abstractLabel.bottomAnchor, constant: 8),
            articleHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            articleHeadline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            
        ])
    }
}
