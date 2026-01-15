//
//  SplashViewController.swift
//  GameVerseApp
//
//  Created by beyyzgur on 14.01.2026.
//

import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var splashTitle1: UILabel!
    @IBOutlet weak var splashTitle2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigateToWelcome()
    }
    
    func navigateToWelcome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            StoryboardNavigableManager.shared.push(storyboardId: .welcoming, delegate: self)
        }
    }

    
}
