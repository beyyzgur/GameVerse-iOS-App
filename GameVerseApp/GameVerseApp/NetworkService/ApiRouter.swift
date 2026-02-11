//
//  ApiRouter.swift
//  GameVerseApp
//
//  Created by beyyzgur on 22.01.2026.
//

import Foundation

protocol ApiRouterProtocol {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var queryItems: [URLQueryItem] { get }
    func request() throws -> URLRequest
}

enum ApiRouter {
    case getAllGames
    case getGameDetail(id: Int)
    case getCategories
    case getTrendingGames
    case searchQuery(text: String)
    case getGameByCategory(genreId: Int)
    case getGamePhoto(id: String) // IMAGE DÖNCEKK
    case getTopRatedGames
    //case getCustomGames
}

extension ApiRouter: ApiRouterProtocol {
    var baseURL: String {
        return "https://api.rawg.io/api"
    }
    
    var path: String {
        switch self {
        case .getAllGames, .getTrendingGames, .searchQuery, .getGameByCategory, .getTopRatedGames:
            return "/games"
        case .getGameDetail(id: let id):
            return "/games/\(id)"
        case .getCategories:
            return "/genres"
        case .getGamePhoto(id: let id):
            return "/games/\(id)/screenshots"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getAllGames, .getGameDetail, .getCategories, .getGamePhoto, .getTrendingGames, .searchQuery, .getGameByCategory, .getTopRatedGames:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem] {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "RAWG_API_KEY") as? String
        else {
            fatalError()
        }
        var items = [URLQueryItem(name: "key", value: apiKey)]
        
        switch self {
        case .getTrendingGames:
            items.append(URLQueryItem(name: "dates", value: "2026-01-01,2026-12-31"))
            items.append(URLQueryItem(name: "ordering", value: "-added"))
        case .searchQuery(text: let text):
            items.append(URLQueryItem(name: "search", value: text))
        case .getGameByCategory(genreId: let genreId):
            items.append(URLQueryItem(name: "genres", value: "\(genreId)"))
        case .getTopRatedGames:
            items.append(URLQueryItem(name: "ordering", value: "-rating"))
            items.append(URLQueryItem(name: "ratings_count", value: "1000"))
        default:
            break
        }
        return items
    }
    
    func request() throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + path ) else { // baseURL + path + "?key="
            throw NetworkError.invalidURL
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        print("debug: Hazırlanan URL: \(url)")
        
        return request
    }
}
