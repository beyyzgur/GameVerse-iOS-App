//
//  ApiResponse.swift
//  GameVerseApp
//
//  Created by beyyzgur on 22.01.2026.
//

import Foundation

struct ApiResponse <T: Decodable>: Decodable {
    var count: Int?
    var next: String?
    var results: [T] // boş olabilir ama null değil 
}

