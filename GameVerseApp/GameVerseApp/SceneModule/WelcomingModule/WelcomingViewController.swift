//
//  WelcomingViewController.swift
//  GameVerseApp
//
//  Created by beyyzgur on 14.01.2026.
//

import UIKit

protocol WelcomingViewControllerInterface: AnyObject {
    func navigateToRegister()
    func navigateToLogin()
}

final class WelcomingViewController: UIViewController {
    @IBOutlet private weak var welcomingTitle1: UILabel!
    @IBOutlet private weak var welcomingTitle2: UILabel!
    
    private lazy var viewmodel: WelcomingViewModelInterface = WelcomingViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func signUpButtonClicked(_ sender: UIButton) {
        viewmodel.didTriggerSignUpButton()
    }
    
    @IBAction private func signInButtonClicked(_ sender: UIButton) {
        viewmodel.didTriggerSignInButton()
    }
}

extension WelcomingViewController: WelcomingViewControllerInterface {
    func navigateToRegister() {
        viewmodel.storyboardNavigableManager.push(storyboardId: .register,
                                                  navigationController: self.navigationController )
    }
    
    func navigateToLogin() {
        viewmodel.storyboardNavigableManager.push(storyboardId: .login,
                                                  navigationController: self.navigationController)
    }
}
