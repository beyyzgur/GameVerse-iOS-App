//
//  SplashViewModel.swift
//  GameVerseApp
//
//  Created by beyyzgur on 19.01.2026.
//

import FirebaseAuth

protocol SplashViewModelInterface {
    var storyboardNavigableManager: StoryboardNavigableManager { get }
}

final class SplashViewModel {
    weak var view: SplashViewControllerInterface?
    var storyboardNavigableManager: StoryboardNavigableManager
    
    init(view: SplashViewControllerInterface,
         storyboardNavigableManager: StoryboardNavigableManager = StoryboardNavigableManager.shared){
        self.view = view
        self.storyboardNavigableManager = storyboardNavigableManager
    }
    
    func routeControl() {
        if Auth.auth().currentUser != nil {
            view?.navigateToTabBar()
        } else {
            view?.navigateToWelcome()
        }
    }
}
