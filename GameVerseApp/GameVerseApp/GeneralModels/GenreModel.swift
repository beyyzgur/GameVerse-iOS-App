//
//  GenreModel.swift
//  GameVerseApp
//
//  Created by beyyzgur on 23.01.2026.
//

import Foundation

struct GenreModel: Codable {
    let id: Int?
    let name: String?
    let imageBackground: String?
    let games: [GenreGames]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, games
        case imageBackground = "image_background"
    }
    
    init(id: Int?, name: String?, imageBackground: String?, games: [GenreGames]?) {
        self.id = id
        self.name = name
        self.imageBackground = imageBackground
        self.games = games
    }
}

struct GenreGames: Codable {
    let id: Int
    let name: String
    let added: Int
}
