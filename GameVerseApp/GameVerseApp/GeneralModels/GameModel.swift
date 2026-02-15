//
//  GameModel.swift
//  GameVerseApp
//
//  Created by beyyzgur on 23.01.2026.
//

import Foundation

struct GameModel: Codable {
    let id: Int?
    let name: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Double?
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, released, rating
        case backgroundImage = "background_image"
        case ratingTop = "rating_top"
    }
    
    init(id: Int?, name: String?, released: String? = nil, backgroundImage: String?, rating: Double? = nil, ratingTop: Double? = nil) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.ratingTop = ratingTop
    }
}
