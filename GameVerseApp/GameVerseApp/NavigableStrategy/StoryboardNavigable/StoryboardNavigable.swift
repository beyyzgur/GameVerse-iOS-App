//
//  StoryboardNavigable.swift
//  GameVerseApp
//
//  Created by beyyzgur on 14.01.2026.
//

import UIKit

protocol StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?,
                     args: Any?) -> Bool
    
    func execute(navigationController: UINavigationController?,
                 delegate: AnyObject?,
                 args: Any?)
}
