//
//  WelcomingViewModel.swift
//  GameVerseApp
//
//  Created by beyyzgur on 15.01.2026.
//

import Foundation

protocol WelcomingViewModelInterface {
    var storyboardNavigableManager: StoryboardNavigableManager { get }
    
    func didTriggerSignUpButton()
    func didTriggerSignInButton()
}

final class WelcomingViewModel {
    weak var view: WelcomingViewControllerInterface?
    var storyboardNavigableManager: StoryboardNavigableManager
    
    init (view: WelcomingViewControllerInterface, // Dependency Inversion / Dependency Injection
          storyboardNavigableManager: StoryboardNavigableManager = StoryboardNavigableManager.shared) {
        self.view = view
        self.storyboardNavigableManager = storyboardNavigableManager
    }
}

extension WelcomingViewModel: WelcomingViewModelInterface {
    func didTriggerSignUpButton() {
        view?.navigateToRegister()
    }
    
    func didTriggerSignInButton() {
        view?.navigateToLogin()
    }
}
