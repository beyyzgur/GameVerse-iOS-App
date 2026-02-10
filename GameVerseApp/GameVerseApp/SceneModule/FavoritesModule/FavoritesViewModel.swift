//
//  FavoritesViewModel.swift
//  GameVerseApp
//
//  Created by beyyzgur on 2.02.2026.
//

import Foundation

protocol FavoritesViewModelInterface {
    var storyboardNavigableManager: StoryboardNavigableManager { get }
    func fetchFavorites()
    func getGame(at index: Int) -> GameModel?
    
    var favoriteGames: [GameModel] { get }
}

final class FavoritesViewModel {
    weak var view: FavoritesViewControllerInterface?
    var storyboardNavigableManager: StoryboardNavigableManager
    private let favoritesManager: FavoritesManager
    
    private(set) var favoriteGames: [GameModel] = []
    
    init(view: FavoritesViewControllerInterface?,
         storyboardNavigableManager: StoryboardNavigableManager = StoryboardNavigableManager.shared,
         favoritesManager: FavoritesManager = FavoritesManager.shared) {
        self.view = view
        self.storyboardNavigableManager = storyboardNavigableManager
        self.favoritesManager = favoritesManager
    }
}

extension FavoritesViewModel: FavoritesViewModelInterface {
    func fetchFavorites() {
        favoriteGames = favoritesManager.getFavorites()
        self.view?.showFavorites(favoriteGames)
    }
    
    func getGame(at index: Int) -> GameModel? {
        return favoriteGames.indices.contains(index) ? favoriteGames[index] : nil
    }
}
