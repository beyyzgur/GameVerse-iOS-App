//
//  WelcomingNavigable.swift
//  GameVerseApp
//
//  Created by beyyzgur on 15.01.2026.
//

import UIKit.UIWindow

final class WelcomingNavigable: StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?,
                     args: Any?) -> Bool {
        return storyboardId == .welcoming
    }
    
    func execute(navigationController: UINavigationController?,
                 delegate: AnyObject?,
                 args: Any?) {
        let welcomingStoryboard = UIStoryboard(name: StoryBoardName.welcoming.rawValue, bundle: nil)
        guard let welcomingViewController = welcomingStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.welcoming.rawValue) as? WelcomingViewController
                else { return }
        guard let presenter = delegate as? UIViewController else { return }
        let welcomingNavController = UINavigationController(rootViewController: welcomingViewController)
        
        welcomingNavController.modalPresentationStyle = .overFullScreen
        presenter.present(welcomingNavController, animated: true)
    }
}
