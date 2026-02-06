//
//  TabBarController.swift
//  GameVerseApp
//
//  Created by beyyzgur on 15.01.2026.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllers()
    }
    
    let homeStoryBoard = UIStoryboard(name: StoryBoardName.home.rawValue, bundle: nil)
    let favoritesStoryBoard = UIStoryboard(name: StoryBoardName.favorites.rawValue, bundle: nil)
    let discoverStoryBoard = UIStoryboard(name: StoryBoardName.discover.rawValue, bundle: nil)
    
    func setupControllers() {
        // MARK: - home
        guard let homeViewController = homeStoryBoard.instantiateViewController(withIdentifier:
                                                                                    StoryboardIdentifier.home.rawValue) as? HomeViewController
          else { return }
        let homeNavController = UINavigationController(rootViewController: homeViewController)
        homeNavController.tabBarItem = UITabBarItem(title: StoryBoardName.home.rawValue,
                                                    image: UIImage(systemName: "house"),
                                                    tag: 0)
        
        // MARK: - discover
        guard let discoverViewController = discoverStoryBoard.instantiateViewController(withIdentifier:
                                                                                            StoryboardIdentifier.discover.rawValue) as? DiscoverViewController
          else { return }
        let discoverNavController = UINavigationController(rootViewController: discoverViewController)
        discoverNavController.tabBarItem = UITabBarItem(title: StoryBoardName.discover.rawValue,
                                                        image: UIImage(systemName: "gamecontroller"),
                                                        tag: 1)
        // MARK: - favorites
        
        guard let favoritesViewController = favoritesStoryBoard.instantiateViewController(withIdentifier:
                                                                                            StoryboardIdentifier.favorites.rawValue) as? FavoritesViewController
          else { return }
        let favoritesNavController = UINavigationController(rootViewController: favoritesViewController)
        favoritesNavController.tabBarItem = UITabBarItem(title: "Wishlist",
                                                         image: UIImage(systemName: "star"),
                                                         tag: 2)
      
        
        setViewControllers([
            homeNavController,
            discoverNavController,
            favoritesNavController
            ],
                           animated: true)
        
    }
}
