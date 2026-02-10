//
//  HomeViewModel.swift
//  GameVerseApp
//
//  Created by beyyzgur on 21.01.2026.
//

protocol HomeViewModelInterface {
    var trendingGames: [TrendingGamesModel] { get }
    var topRatedGames: [GameModel] { get }
    var storyboardNavigableManager: StoryboardNavigableManager { get }
    
    func fetchTrendingGames()
    func fetchTopRatedGames()
}

final class HomeViewModel {
    weak var view: HomeViewControllerInterface? // hep view week olur genelde
    var apiService: ApiService
    var storyboardNavigableManager: StoryboardNavigableManager
    
    var trendingGames: [TrendingGamesModel] = []
    var topRatedGames: [GameModel] = []
    
    init(view: HomeViewControllerInterface,
         apiService: ApiService = ApiService.shared,
         storyboardNavigableManager: StoryboardNavigableManager = StoryboardNavigableManager.shared) {
        self.view = view
        self.apiService = apiService
        self.storyboardNavigableManager = storyboardNavigableManager
    }
}

extension HomeViewModel: HomeViewModelInterface {
    func fetchTrendingGames() {
        Task {
            do {
                let response: ApiResponse<TrendingGamesModel> = try await apiService.request(.getTrendingGames)
                self.trendingGames = response.results
                
                await MainActor.run {
                    self.view?.showTrendingGames(trendingGames)
                }
            } catch {
                print("Trending Games Error: \(error)")
                self.view?.makeAlert(title: "Error", message: "Trending Games not found", onOK: nil)
            }
        }
    }
    
    func fetchTopRatedGames() {
        Task {
            do {
                let response: ApiResponse<GameModel> = try await apiService.request(.getTopRatedGames)
                self.topRatedGames = response.results
                
                await MainActor.run {
                    self.view?.showTopRatedGames(topRatedGames)
                }
                
            } catch {
                self.view?.makeAlert(title: "Error", message: "Top Rated Games not found.", onOK: nil)
            }
        }
    }
}
