//
//  FavoriteModel.swift
//  PerqaraTest
//
//  Created by aditya  on 26/02/23.
//

import Foundation
import RealmSwift

class FavoriteModel: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var imageURL: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var isRating: Bool = false
}
