//
//  VideoResponce.swift
//  The Movie Database
//
//  Created by Pavel Shabliy on 14.03.2023.
//

import Foundation

struct VideoResponce: Codable {
    let id: Int
    let results: [VideoResult]
}

struct VideoResult: Codable {
    let key: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case key
        case id
    }
}
