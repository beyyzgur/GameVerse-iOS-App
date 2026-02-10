//
//  HomeNavigable.swift
//  GameVerseApp
//
//  Created by beyyzgur on 16.01.2026.
//

import UIKit.UIWindow

final class HomeNavigable: StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?,
                     args: Any?) -> Bool {
        return storyboardId == .home
    }
    
    func execute(navigationController: UINavigationController?,
                 delegate: AnyObject?,
                 args: Any?) {
        let homeStoryBoard = UIStoryboard(name: StoryBoardName.home.rawValue, bundle: nil)
        guard let homeViewController = homeStoryBoard.instantiateViewController(withIdentifier:
                                                                                StoryboardIdentifier.home.rawValue)
                as? HomeViewController else { return }
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        
        homeNavigationController.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(homeNavigationController, animated: true)
    }
}
