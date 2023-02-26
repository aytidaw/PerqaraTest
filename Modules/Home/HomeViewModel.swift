//
//  HomeViewModel.swift
//  PerqaraTest
//
//  Created by aditya  on 25/02/23.
//

import Foundation

protocol HomeViewModelDelegate {
    func success(data: [ResultModel])
    func failedReq(message: String)
}

class HomeViewModel {
    
    var delegate: HomeViewModelDelegate?
    
    var homeApi = HomeApi()
    
    init() {
        homeApi.delegate = self
    }
    
    func getData(page: Int, perPage: Int) {
        homeApi.getData(page: page, pageSize: perPage)
    }
    
}

// MARK: - CoreApiDelegate
extension HomeViewModel: CoreApiDelegate {
    
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        do {

            let data = try JSONDecoder().decode(HomeModel.self, from: data)
            
            if let validData = data.results {
                delegate?.success(data: validData)
            }
            
        } catch {
            print("error")
        }
    }
    
    func failed(interFace: CoreApi, result: AnyObject) {
        delegate?.failedReq(message: "Error From Service")
    }
}
