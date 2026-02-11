//
//  StoryboardNavigableManager.swift
//  GameVerseApp
//
//  Created by beyyzgur on 14.01.2026.
//

import UIKit

class StoryboardNavigableManager {
    static let shared = StoryboardNavigableManager()
    
    private init() {}
    
    let items : [StoryboardNavigable] = [
        WelcomingNavigable(),
        RegisterNavigable(),
        LoginNavigable(),
        TabBarNavigable(),
        HomeNavigable(),
        DetailNavigable(),
        DiscoverNavigable(),
        FavoritesNavigable()
    ]
    
    func push(storyboardId: StoryboardIdentifier,
              navigationController: UINavigationController? = nil,
              delegate: AnyObject? = nil,
              args: Any? = nil) {
        guard let items = items.first(where: {
            $0.isSatisfied(storyboardId: storyboardId, delegate: delegate, args: args)
        })
        else { return }
        
        DispatchQueue.main.async {
            items.execute(navigationController: navigationController, delegate: delegate, args: args)
        }
    }
    
}
