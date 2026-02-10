//
//  DiscoverViewModel.swift
//  GameVerseApp
//
//  Created by beyyzgur on 30.01.2026.
//

import Foundation

protocol DiscoverViewModelInterface {
    var storyboardNavigableManager: StoryboardNavigableManager { get }
    var genres: [GenreModel] { get }
    var games: [GameModel] { get }
    
    func fetchGenres()
    func fetchGames()
    func searchGames(with text: String)
    func fetchGamesByCategory(id: Int)
    func didSelectGenre(at index: Int)
}

final class DiscoverViewModel {
    weak var view: DiscoverViewControllerInterface?
    var apiService: ApiService
    var storyboardNavigableManager: StoryboardNavigableManager
    
    var genres: [GenreModel] = []
    var games: [GameModel] = []
    private var searchWorkItem: DispatchWorkItem?
    
    init(view: DiscoverViewControllerInterface?,
         apiService: ApiService = ApiService.shared,
         storyboardNavigableManager: StoryboardNavigableManager = StoryboardNavigableManager.shared) {
        self.view = view
        self.apiService = apiService
        self.storyboardNavigableManager = storyboardNavigableManager
    }
    
    func searchGames(with text: String) {
        searchWorkItem?.cancel()
        
        let task = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            self.performSearch(with: text)
        }
        searchWorkItem = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: task)
    }
    
}
extension DiscoverViewModel: DiscoverViewModelInterface {
    func fetchGenres() {
        Task {
            do {
                let response: ApiResponse<GenreModel> = try await apiService.request(.getCategories)
                
                let allCategoryPill = GenreModel(id: nil, name: "All", imageBackground: nil, games: nil)
                self.genres = [allCategoryPill] + response.results

                await MainActor.run {
                    self.view?.showGenres(response.results)
                }
            } catch {
                await MainActor.run {
                    self.view?.makeAlert(title: "Error", message: "Genres not found", onOK: nil)
                }
            }
        }
    }
    
    func fetchGames() {
        Task {
            do {
                let response: ApiResponse<GameModel> = try await apiService.request(.getAllGames)
                self.games = response.results
                
                await MainActor.run {
                    self.view?.showGames(games)
                }
            } catch {
                self.view?.makeAlert(title: "Error", message: "Games not found", onOK: nil)
            }
        }
    }
    
    func performSearch(with text: String) {
        Task {
            do {
                if !text.isEmpty {
                    let response: ApiResponse<GameModel> = try await apiService.request(.searchQuery(text: text))
                    self.games = response.results
                    
                    await MainActor.run {
                        self.view?.showGames(self.games)
                    }
                } else {
                    self.fetchGames()
                }
            } catch {
                self.view?.makeAlert(title: "Error", message: "Search failed", onOK: nil)
            }
        }
    }
    
    func didSelectGenre(at index: Int) {
        guard index < genres.count else { return }
        
        if let genreId = genres[index].id {
            fetchGamesByCategory(id: genreId)
        } else {
            fetchGames()
        }
    }
    
    func fetchGamesByCategory(id: Int) {
        Task {
            do {
                let response: ApiResponse<GameModel> = try await apiService.request(.getGameByCategory(genreId: id))
                self.games = response.results
                
                await MainActor.run {
                    self.view?.showGames(self.games)
                }
            } catch {
                self.view?.makeAlert(title: "Error", message: "This category has no games", onOK: nil)
            }
        }
    }
}
