//
//  ProductDetailViewModel.swift
//  PerqaraTest
//
//  Created by aditya  on 25/02/23.
//


import Foundation
import RealmSwift

protocol ProductDetailViewModelDelegate {
    func success(data: ProductModel)
    func failedReq(message: String)
}

class ProductDetailViewModel {
    
    var detailID: Int?
    var delegate: ProductDetailViewModelDelegate?
    var detailApi = DetailApi()
    let realm = RealmManager.shared
    var favoriteData: [FavoriteModel] = []

    init() {
        detailApi.delegate = self
    }
    
    func getData() {
        detailApi.getData(id: detailID ?? 0)
    }
    
    func getDataFromRealm() {
        favoriteData = realm.getFavoriteData()
    }
    
}

// MARK: - CoreApiDelegate
extension ProductDetailViewModel: CoreApiDelegate {
    
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        do {

            let validData = try JSONDecoder().decode(ProductModel.self, from: data)
            
            delegate?.success(data: validData)
            
        } catch {
            print("error")
        }
    }
    
    func failed(interFace: CoreApi, result: AnyObject) {
        delegate?.failedReq(message: "Error From Service")
    }
}
