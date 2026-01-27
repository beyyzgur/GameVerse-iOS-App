//
//  LoginNavigable.swift
//  GameVerseApp
//
//  Created by beyyzgur on 15.01.2026.
//

import UIKit.UIWindow

final class LoginNavigable: StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?,
                     args: Any?) -> Bool {
        return storyboardId == .login
    }
    
    func execute(navigationController: UINavigationController?,
                 delegate: AnyObject?,
                 args: Any?) {
        let loginStoryboard = UIStoryboard(name: StoryBoardName.login.rawValue, bundle: nil)
        guard let loginViewController = loginStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.login.rawValue)
                as? LoginViewController else { return }
        
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}
