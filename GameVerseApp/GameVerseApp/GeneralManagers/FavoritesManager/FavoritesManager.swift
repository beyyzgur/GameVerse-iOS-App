//
//  FavoritesManager.swift
//  GameVerseApp
//
//  Created by beyyzgur on 3.02.2026.
//

import Foundation

protocol FavoritesManagerInterface {
    func getFavorites() -> [GameModel]
    func addToFavorites(_ game: GameModel)
    func removeFavorite(gameId: Int)
    func isFavorite(gameId: Int) -> Bool
}

final class FavoritesManager {
    static let shared = FavoritesManager()
    private let defaults = UserDefaults.standard
    private let favoritesKey = "user_favorites"
    
    private init() {}
    
    func save(_ favorites: [GameModel]) {
        do {
            let data = try JSONEncoder().encode(favorites)
            defaults.set(data, forKey: favoritesKey)
        } catch {
            print("Favoriler kaydedilemedi: \(error.localizedDescription)")
        }
    }
}

extension FavoritesManager: FavoritesManagerInterface {
    func getFavorites() -> [GameModel] {
        guard let data = defaults.data(forKey: favoritesKey) else { return [] }
        do {
            return try JSONDecoder().decode([GameModel].self, from: data)
        } catch { // viewcontrollerda olmadıgımız için make alert kullanamayoruz
            print("Favoriler decode edilemedi: \(error.localizedDescription)")
            return []
        }
    }
    
    func addToFavorites(_ game: GameModel) {
        var currentFavorites = getFavorites()
        if !currentFavorites.contains(where: { $0.id == game.id}) {
            currentFavorites.append(game)
            save(currentFavorites)
        }
    }
    
    func removeFavorite(gameId: Int) {
        var currentFavorites = getFavorites()
        currentFavorites.removeAll() { $0.id == gameId }
        save(currentFavorites)
    }
    
    func isFavorite(gameId: Int) -> Bool {
        return getFavorites().contains(where: { $0.id == gameId })
    }
    
    
}
