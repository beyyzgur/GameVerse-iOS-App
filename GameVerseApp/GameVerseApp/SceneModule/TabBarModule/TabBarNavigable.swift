//
//  TabBarNavigable.swift
//  GameVerseApp
//
//  Created by beyyzgur on 16.01.2026.
//

import UIKit.UIWindow

final class TabBarNavigable: StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?,
                     args: Any?) -> Bool {
        return storyboardId == .tabBar
    }
    
    func execute(navigationController: UINavigationController?,
                 delegate: AnyObject?,
                 args: Any?) {
        let tabBarStoryoard = UIStoryboard(name: StoryBoardName.tabBar.rawValue, bundle: nil)
        guard let tabBarViewController = tabBarStoryoard.instantiateViewController(withIdentifier:
                                                                                    StoryboardIdentifier.tabBar.rawValue) as? TabBarController
        else { return }
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        else { return }
        
        sceneDelegate.setRootViewController(tabBarViewController)
    }
}
