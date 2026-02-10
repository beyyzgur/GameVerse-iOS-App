//
//  DetailNavigable.swift
//  GameVerseApp
//
//  Created by beyyzgur on 25.01.2026.
//

import UIKit.UIWindow

class DetailNavigable: StoryboardNavigable {
    func isSatisfied(storyboardId: StoryboardIdentifier,
                     delegate: AnyObject?,
                     args: Any?) -> Bool {
        return storyboardId == .detail
    }
    
    func execute(navigationController: UINavigationController?,
                 delegate: AnyObject?,
                 args: Any?) {
        let detailStoryboard = UIStoryboard(name: StoryBoardName.detail.rawValue, bundle: nil)
        guard let detailViewController = detailStoryboard.instantiateViewController(withIdentifier:
                                                                                        StoryboardIdentifier.detail.rawValue)
                as? DetailViewController else {
            print("❌ HATA: DetailViewController bulunamadı veya ID yanlış!")
            return }
        
        if let gameId = args as? Int {
            detailViewController.gameId = gameId
        }
        
        if navigationController == nil {
                print("❌ HATA: navigationController nil geliyor!")
            }
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
