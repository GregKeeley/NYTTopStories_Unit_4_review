//
//  emptyView.swift
//  NYTTopStories_Unit_4_review
//
//  Created by Gregory Keeley on 2/10/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    public lazy var titleLabel: UILabel =  {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Empty collection"
        return label
    }()
    public lazy var messageLabel: UILabel =  {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 4
        label.textAlignment = .center
        label.text = "There are no items currently in your collection"
        return label
    }()
//    override init(frame: CGRect) {
//        super.init(frame: UIScreen.main.bounds)
//        commonInit()
//    }
    init(title: String, message: String) {
        super.init(frame: UIScreen.main.bounds)
        self.titleLabel.text = title
        self.messageLabel.text = message
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        constraintsMessageLabel()
        constraintsTitleLabel()
    }
    private func constraintsTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            titleLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
            
        ])
    }
    private func constraintsMessageLabel() {
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        
        ])
    }
}
