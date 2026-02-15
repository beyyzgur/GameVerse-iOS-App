//
//  TrendingGamesModel.swift
//  GameVerseApp
//
//  Created by beyyzgur on 23.01.2026.
//

import Foundation

struct TrendingGamesModel: Codable {
    var id: Int?
    var name: String?
    var backgroundImage: String?
    var rating: Double?
    var ratingTop: Double?
    var suggestionsCount: Int?
    var genres: [TrendingGamesGenre]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, rating, genres
        case backgroundImage = "background_image"
        case suggestionsCount = "suggestions_count"
        case ratingTop = "rating_top"
    }
    
    init(id: Int?,
         name: String? = nil,
         backgroundImage: String? = nil,
         rating: Double? = nil,
         ratingTop: Double? = nil,
         suggestionsCount: Int? = nil,
         genres: [TrendingGamesGenre]? = nil) {
        self.id = id
        self.name = name
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.ratingTop = ratingTop
        self.suggestionsCount = suggestionsCount
        self.genres = genres
    }
}

struct TrendingGamesGenre: Codable {
    var id: Int?
    var name: String?
}
