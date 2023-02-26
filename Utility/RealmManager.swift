//
//  RealmManager.swift
//  PerqaraTest
//
//  Created by aditya  on 26/02/23.
//

import Foundation
import RealmSwift
import Realm

class RealmManager: NSObject {
    
    static let shared = RealmManager()
    let realm = try! Realm()
    
    func createFavoriteData(id: Int, title: String, imageUrl: String, released: String, rating: Double, isRating: Bool) {
        do {
            try realm.write {
                let history = FavoriteModel()
                history.id = id
                history.imageURL = imageUrl
                history.title = title
                history.released = released
                history.rating = rating
                history.isRating = isRating
                realm.add(history)
            }
        } catch {
            print("error creating history data: \(error)")
        }
    }
    
    func getFavoriteData() -> [FavoriteModel] {
        var favorite: [FavoriteModel] = []
        let data = realm.objects(FavoriteModel.self)
        favorite.append(contentsOf: data)
        return favorite
    }
    
    
    func delete(_ objects : Object) {
        try! realm.write {
            realm.delete(objects)
        }
    }
    
}
