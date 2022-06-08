//
//  User.swift
//  SwiftUIof100Days
//
//  Created by Ray on 2022/6/8.
//

import Foundation

final class UserX: ObservableObject, Codable {
    
    @Published var name = "Ray"
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let value = try container.decodeIfPresent(String.self, forKey: .name) {
            name = value
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
    }
}

struct Response: Codable {
    
    var results: [Result]
}

struct Result: Codable {
    
    var trackId: Int
    var trackName: String
    var collectionName: String
    
}
