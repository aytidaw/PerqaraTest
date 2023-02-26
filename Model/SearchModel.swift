//
//  SearchModel.swift
//  PerqaraTest
//
//  Created by aditya  on 26/02/23.
//

import Foundation

struct SearchModel: Codable {
    var count: Int?
    var next: String?
    var results: [ResultSearchModel]?
    var description: String?
}

struct ResultSearchModel: Codable {
    var id: Int?
    var slug, name, released: String?
    var background_image: String?
    var rating: Double?
}
