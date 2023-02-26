//
//  ProductModel.swift
//  PerqaraTest
//
//  Created by aditya  on 26/02/23.
//

import Foundation

struct ProductModel: Codable {
    var id: Int?
    var slug, name, description : String?
    var background_image: String?
    var rating: Double?
    var playtime: Int?
    var released: String?
    var publishers: [PublisherModel]?
}

struct PublisherModel: Codable {
    var id: Int?
    var slug, name : String?
    var image_background: String?
    var games_count: Double?
}

