//
//  NYTTopStoriesTabController.swift
//  NYTTopStories_Unit_4_review
//
//  Created by Gregory Keeley on 2/6/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit
import DataPersistence

class NYTTopStoriesTabController: UITabBarController {

    private var dataPersistence = DataPersistence<Article>(filename: "savedArticles.plist")
    
    private lazy var newsFeedVC: NewsFeedViewController = {
        let viewController = NewsFeedViewController()
        viewController.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(systemName: "eyeglasses"), tag: 0)
        viewController.dataPersistence = dataPersistence
        return viewController
    }()
    private lazy var savedArticlesVC: SavedArticleViewController = {
        let viewController = SavedArticleViewController()
        viewController.tabBarItem = UITabBarItem(title: "Saved Articles", image: UIImage(systemName: "folder"), tag: 1)
        viewController.dataPersistence = dataPersistence
        // We set the delegate as (self) viewController here, because the actual VC wont set until it is called (tapped on)
        // this tabBarController gets instantiated as the rootViewController
        viewController.dataPersistence.delegate = viewController
        return viewController
    }()
    private lazy var settingsVC: SettingsViewController = {
        let viewController = SettingsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        return viewController
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [UINavigationController(rootViewController: newsFeedVC), UINavigationController(rootViewController: savedArticlesVC), UINavigationController(rootViewController: settingsVC)]
    }
    

   

}
