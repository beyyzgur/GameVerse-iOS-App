//
//  LoginViewModel.swift
//  GameVerseApp
//
//  Created by beyyzgur on 15.01.2026.
//

import Foundation
import FirebaseAuth

protocol LoginViewModelInterface {
    var storyboardNavigableManager: StoryboardNavigableManager { get }
}

final class LoginViewModel {
    var emailTextField: String = ""
    var passwordTextField: String = ""
    
    weak var view: LoginViewControllerInterface?
    var storyboardNavigableManager: StoryboardNavigableManager
    
    init (view: LoginViewControllerInterface, storyboardNavigableManager: StoryboardNavigableManager = StoryboardNavigableManager.shared) {
        self.view = view
        self.storyboardNavigableManager = storyboardNavigableManager
    }
    
    private func isFormValid() -> Bool {
        return !emailTextField.isEmpty && !passwordTextField.isEmpty
    }
    
    func login() {
        guard isFormValid() else {
            view?.makeAlert(title: "Error", message: "Invalid Form Informations", onOK: nil)
            return }
        Auth.auth().signIn(withEmail: emailTextField, password: passwordTextField) { [weak self] result, error in
            guard let self else { return }
            if let error = error {
                view?.makeAlert(title: "Error", message: error.localizedDescription, onOK: nil)
            } else {
                view?.makeAlert(title:"Succesfully Signed In", message: "You are being directed to the app" ) {
                    self.navigateToTabbarController()
                }
            }
            return
        }
    }
    
    func navigateToTabbarController() {
        view?.navigateToTabBar()
    }
}
