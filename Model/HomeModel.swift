//
//  HomeModel.swift
//  PerqaraTest
//
//  Created by aditya  on 25/02/23.
//
 
import Foundation

// MARK: - HomeModel
struct HomeModel: Codable {
    var count: Int?
    var next: String?
    var results: [ResultModel]?
    var description: String?
}

// MARK: - ResultModel
struct ResultModel: Codable {
    var id: Int?
    var slug, name, released: String?
    var background_image: String?
    var rating: Double?
    
//    enum CodingKeys: String, CodingKey {
//        case id, slug, name, released
//        case backgroundImage = "background_image"
//        case rating
//    }
}

// MARK: - AddedByStatusModel
struct AddedByStatusModel: Codable {
    var yet, owned, beaten, toplay: Int?
    var dropped, playing: Int?
}

// MARK: - EsrbRating
struct EsrbRatingModel: Codable {
    var id: Int?
    var name, slug: String?
}

// MARK: - Genre
struct GenreModel: Codable {
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
}

// MARK: - PlatformElement
struct PlatformElementModel: Codable {
    var platform: PlatformPlatformModel?
    var releasedAt: String?
}

// MARK: - PlatformPlatform
struct PlatformPlatformModel: Codable {
    var id: Int?
    var name, slug: String?
    var yearStart: Int?
    var gamesCount: Int?
    var imageBackground: String?
}

// MARK: - Rating
struct RatingModel: Codable {
    var id: Int?
    var title: TitleModel?
    var count: Int?
    var percent: Double?
}

enum TitleModel: Codable {
    case exceptional
    case meh
    case recommended
    case skip
}

// MARK: - Store
struct StoreModel: Codable {
    var id: Int?
    var store: GenreModel?
}
