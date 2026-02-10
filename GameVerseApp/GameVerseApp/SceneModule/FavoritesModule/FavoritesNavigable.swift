//
//  FavoritesNavigable.swift
//  GameVerseApp
//
//  Created by beyyzgur on 2.02.2026.
//

import UIKit.UIWindow

class FavoritesNavigable: StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?, args: Any?) -> Bool {
        return storyboardId == .favorites
    }
    
    func execute(navigationController: UINavigationController?,
                 delegate: AnyObject?,
                 args: Any?) {
        let favoritesStoryboard = UIStoryboard(name: StoryBoardName.favorites.rawValue, bundle: nil)
        guard let favoritesViewController = favoritesStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.favorites.rawValue) as? FavoritesViewController else { return }
        
        let navController = UINavigationController(rootViewController: favoritesViewController)
        navController.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(navController, animated: true)
    }
}
