//
//  SplashViewController.swift
//  GameVerseApp
//
//  Created by beyyzgur on 14.01.2026.
//

import UIKit

protocol SplashViewControllerInterface: AnyObject {
    func navigateToTabBar()
    func navigateToWelcome()
}

final class SplashViewController: UIViewController {
    @IBOutlet weak var splashTitle1: UILabel!
    @IBOutlet weak var splashTitle2: UILabel!
    
    private lazy var viewModel = SplashViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        route()
    }
    
    func route() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.routeControl()
        }
    }
}

extension SplashViewController: SplashViewControllerInterface {
    func navigateToTabBar() {
        viewModel.storyboardNavigableManager.push(storyboardId: .tabBar,
                                                  delegate: self)
    }
    
    func navigateToWelcome() {
        viewModel.storyboardNavigableManager.push(storyboardId: .welcoming,
                                                  delegate: self)
    }
}
