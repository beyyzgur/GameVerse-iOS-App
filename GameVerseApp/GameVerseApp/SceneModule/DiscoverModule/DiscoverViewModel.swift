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
    
    func fetchInitialAPIRequests()
    func fetchGenres() async
    func fetchGames() async
    func searchGames(with text: String)
    func fetchGamesByCategory(id: Int) async
    func didSelectGenre(at index: Int)
    func fetchNextPageGames()
}

final class DiscoverViewModel {
    weak var view: DiscoverViewControllerInterface?
    var apiService: ApiService
    var storyboardNavigableManager: StoryboardNavigableManager
    var isLoadingMore: Bool = false
    
    var genres: [GenreModel] = []
    var games: [GameModel] = []
    private var searchWorkItem: DispatchWorkItem?
    private var nextUrlString: String?
    
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
    func fetchInitialAPIRequests() {
        Task {
            view?.showProgress()
            async let fetchGenres: Void = fetchGenres()
            async let fetchGames: Void = fetchGames()
            
            _ = await (fetchGenres, fetchGames)
            view?.removeProgress()
        }
    }
    
    func fetchGenres() async {
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
    
    
    func fetchGames() async {
        do {
            let response: ApiResponse<GameModel> = try await apiService.request(.getAllGames)
            self.games = response.results
            self.nextUrlString = response.next
            
            await MainActor.run {
                self.view?.showGames(games)
            }
        } catch {
            self.view?.makeAlert(title: "Error", message: "Games not found", onOK: nil)
        }
    }
    
    func performSearch(with text: String) {
        Task {
            view?.showProgress()
            do {
                if !text.isEmpty {
                    let response: ApiResponse<GameModel> = try await apiService.request(.searchQuery(text: text))
                    self.games = response.results
                    self.nextUrlString = response.next
                    
                    await MainActor.run {
                        self.view?.showGames(self.games)
                    }
                } else {
                    await self.fetchGames()
                }
            } catch {
                self.view?.makeAlert(title: "Error", message: "Search failed", onOK: nil)
            }
            view?.removeProgress()
        }
    }
    
    func didSelectGenre(at index: Int) {
        Task {
            view?.showProgress()
            await didSelectGenreInternal(at: index)
            view?.removeProgress()
        }
    }
    
    func didSelectGenreInternal(at index: Int) async {
        guard index < genres.count else { return }
        
        if let genreId = genres[index].id {
            await fetchGamesByCategory(id: genreId)
        } else {
            await fetchGames()
        }
    }
    
    func fetchGamesByCategory(id: Int) async {
        do {
            let response: ApiResponse<GameModel> = try await apiService.request(.getGameByCategory(genreId: id))
            self.games = response.results
            self.nextUrlString = response.next
            
            await MainActor.run {
                self.view?.showGames(self.games)
            }
        } catch {
            self.view?.makeAlert(title: "Error", message: "This category has no games", onOK: nil)
        }
    }
    
    func fetchNextPageGames() {
        Task {
            view?.showProgress()
            await fetchNextPageGamesInternal()
            view?.removeProgress()
        }
    }
    
    func fetchNextPageGamesInternal() async {
        guard !isLoadingMore, let nextUrl = nextUrlString else { return }
    
        isLoadingMore = true
        
        do {
            let response: ApiResponse<GameModel> = try await apiService.request(.getNextPage(url: nextUrl))
            self.nextUrlString = response.next
            
            self.games.append(contentsOf: response.results)
            
            await MainActor.run {
                self.isLoadingMore = false
                self.view?.showGames(self.games)
            }
        } catch {
            await MainActor.run {
                self.isLoadingMore = false
                print("Pagination Error: \(error)")
            }
        }
    }
}
