//
//  DetailViewModel.swift
//  GameVerseApp
//
//  Created by beyyzgur on 25.01.2026.
//

import Foundation

protocol DetailViewModelInterface {
    var storyboardNavigableManager: StoryboardNavigableManager { get }
    var gameDetails: [GameDetailModel] { get }
    
    func fetchGameDetails()
    func toggleFavorite(model: GameDetailModel)
    func checkIsFavorite(_ gameId: Int) -> Bool
}

final class DetailViewModel {
    weak var view: DetailViewControllerInterface?
    var apiService: ApiService
    var storyboardNavigableManager: StoryboardNavigableManager
    
    var gameDetails: [GameDetailModel] = []
    let gameId: Int
    
    init(view: DetailViewControllerInterface,
         gameId: Int,
         apiService: ApiService = ApiService.shared,
         storyboardNavigableManager: StoryboardNavigableManager = StoryboardNavigableManager.shared) {
        self.view = view
        self.gameId = gameId
        self.apiService = apiService
        self.storyboardNavigableManager = storyboardNavigableManager
    }
}

extension DetailViewModel: DetailViewModelInterface {
    func fetchGameDetails() {
        Task {
            do {
                let response: GameDetailModel = try await apiService.request(.getGameDetail(id: self.gameId))
                self.gameDetails = [response]
                
                await MainActor.run {
                    self.view?.showGameDetails(self.gameDetails)
                }
                
            } catch {
                self.view?.makeAlert(title: "Error", message: "Details not found.", onOK: nil)
            }
        }
    }
    
    func toggleFavorite(model: GameDetailModel) {
        let game = GameModel(id: model.id, name: model.name, backgroundImage: model.backgroundImage)
        if FavoritesManager.shared.isFavorite(gameId: game.id!) { // burada napacağımı bilemedim o yüzden ! kullandım
            FavoritesManager.shared.removeFavorite(gameId: game.id!)
        } else {
            FavoritesManager.shared.addToFavorites(game)
        }
        self.view?.showGameDetails(self.gameDetails) // reload data için
    }
    
    func checkIsFavorite(_ gameId: Int) -> Bool {
        FavoritesManager.shared.isFavorite(gameId: gameId)
    }
}
