//
//  RegisterNavigable.swift
//  GameVerseApp
//
//  Created by beyyzgur on 13.01.2026.
//

import UIKit.UIWindow

final class RegisterNavigable: StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?,
                     args: Any?) -> Bool {
        return storyboardId == .register
    }
    
    func execute(navigationController: UINavigationController?,
                 delegate: AnyObject?,
                 args: Any?) {
        let registerStoryboard = UIStoryboard(name: StoryBoardName.register.rawValue, bundle: nil)
        guard let registerViewController = registerStoryboard.instantiateViewController(withIdentifier: StoryboardIdentifier.register.rawValue)
                as? RegisterViewController else { return }
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}
