//
//  GameDetailModel.swift
//  GameVerseApp
//
//  Created by beyyzgur on 26.01.2026.
//

struct GameDetailModel: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let released: String?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let playtime: Int?
    let genres: [DetailGenreModel]?
    let esrbRating: ESRBModel?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, released, rating, playtime, genres
        case backgroundImage = "background_image"
        case ratingTop = "rating_top"
        case esrbRating = "esrb_rating"
    }
    
    init(id: Int?,
         name: String?,
         description: String?,
         released: String?,
         backgroundImage: String?,
         rating: Double?,
         ratingTop: Int?,
         playtime: Int?,
         genres: [DetailGenreModel]?,
         esrbRating: ESRBModel?) {
        self.id = id
        self.name = name
        self.description = description
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.ratingTop = ratingTop
        self.playtime = playtime
        self.genres = genres
        self.esrbRating = esrbRating
    }
}

 struct ESRBModel: Codable {
    let id: Int?
    let name: String?
     
     init(id: Int?, name: String?) {
         self.id = id
         self.name = name
     }
}

struct DetailGenreModel: Codable {
    let id: Int?
    let name: String?
    
    init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
}
