//
//  FavouriteViewModel.swift
//  PerqaraTest
//
//  Created by aditya  on 25/02/23.
//

import Foundation
import RealmSwift
import UIKit

protocol FavouriteViewModelDelegate {
    func successGetData(data: [FavoriteModel])
}

class FavouriteViewModel {
    
    var delegate: FavouriteViewModelDelegate?
    
    var favoriteData: [FavoriteModel] = []
    
    let realm = RealmManager.shared
    
    func getData() {
        favoriteData = realm.getFavoriteData()
        delegate?.successGetData(data: favoriteData)
    }
}
