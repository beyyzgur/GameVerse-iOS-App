//
//  NetworkError.swift
//  GameVerseApp
//
//  Created by beyyzgur on 22.01.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case encodingError
    case unauthorized // 401
    case forbidden  // 403
    case notFound  // 404
    case serverError(statusCode: Int)  // 500
    case timeout
    case invalidResponse
    case decodingError
    case unknown(statusCode: Int)
    case backendMessage(String)


var errorDescription: String? {
    switch self {
    case .backendMessage(let message):
        return message
    case .invalidURL:
        return "Geçersiz URL"
    case .encodingError:
        return "Veri kodlama hatası."
    case .unauthorized:
        return "Yetkisiz erişim."
    case .forbidden:
        return "Erişim engellendi."
    case .notFound:
        return "Kaynak bulunamadı"
    case .serverError:
        return "Sunucu hatası oluştu."
    case .timeout:
        return "İstek zaman aşımına uğradı."
    case .invalidResponse:
        return "Geçersiz yanıt alındı."
    case .decodingError:
        return "Veri çözümleme hatası."
    case .unknown(statusCode: let statusCode):
        return "Bilinmeyen bir hata oluştu. Kod \(statusCode)"
    }
}
}
