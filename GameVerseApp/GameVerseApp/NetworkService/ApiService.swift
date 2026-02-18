//
//  ApiService.swift
//  GameVerseApp
//
//  Created by beyyzgur on 22.01.2026.
//

import Foundation

protocol ApiServiceProtocol {
    func request<T: Decodable>(_ router: ApiRouter) async throws -> T
}

final class ApiService: ApiServiceProtocol {
    static let shared = ApiService()
    
    private init() {}
    
    func request<T: Decodable>(_ router: ApiRouter) async throws -> T {
        let request = try router.request()
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
           throw NetworkError.decodingError
        }
    }
}
