//
//  DiscoverNavigable.swift
//  GameVerseApp
//
//  Created by beyyzgur on 30.01.2026.
//

import UIKit.UIWindow

final class DiscoverNavigable: StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?, args: Any?) -> Bool {
        return storyboardId == .discover
    }
    
    func execute(navigationController: UINavigationController?,
                 delegate: AnyObject?,
                 args: Any?) {
        let discoverStoryboard = UIStoryboard(name: StoryBoardName.discover.rawValue, bundle: nil)
        guard let discoverViewController = discoverStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.discover.rawValue) as? DiscoverViewController else {
            fatalError()
        }
        let discoverNavigationController = UINavigationController(rootViewController: discoverViewController)
        discoverNavigationController.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(discoverNavigationController, animated: true)
    }
}
