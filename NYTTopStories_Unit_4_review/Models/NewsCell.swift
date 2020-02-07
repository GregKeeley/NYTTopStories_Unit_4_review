//
//  NewsCell.swift
//  NYTTopStories_Unit_4_review
//
//  Created by Gregory Keeley on 2/7/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    public lazy var articleImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.backgroundColor = .green
        image.contentMode = .scaleAspectFill
        return image
    }()
    public lazy var articleTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Article Title Cowabunga!"
        return label
    }()
    public lazy var abstractHeadlineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.text = "Abstract headline pizza time!"
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        setuparticleImage()
        setupArticleTitleLabel()
        setupAbstractHeadlineLabelConstraint()
    }
    private func setuparticleImage() {
        addSubview(articleImage)
        articleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            articleImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            articleImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            articleImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30),
            articleImage.widthAnchor.constraint(equalTo: articleImage.heightAnchor)
        
        ])
    }
    private func setupArticleTitleLabel() {
        addSubview(articleTitleLabel)
        articleTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            articleTitleLabel.topAnchor.constraint(equalTo: articleImage.topAnchor),
            articleTitleLabel.leadingAnchor.constraint(equalTo: articleImage.trailingAnchor, constant: 8),
            articleTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        
        ])
    }
    private func setupAbstractHeadlineLabelConstraint() {
        addSubview(abstractHeadlineLabel)
        abstractHeadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            abstractHeadlineLabel.leadingAnchor.constraint(equalTo: articleTitleLabel.leadingAnchor),
            abstractHeadlineLabel.trailingAnchor.constraint(equalTo: articleTitleLabel.trailingAnchor),
            abstractHeadlineLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: 8)
            
        ])
    }

}
