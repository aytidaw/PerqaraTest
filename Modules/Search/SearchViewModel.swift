//
//  SearchViewModel.swift
//  PerqaraTest
//
//  Created by aditya  on 25/02/23.
//

import Foundation

protocol SearchViewModelDelegate {
    func success(data: [ResultSearchModel])
    func failedReq(message: String)
}

class SearchViewModel {
    
    var delegate: SearchViewModelDelegate?
    
    var searchApi = SearchApi()
    
    init() {
        searchApi.delegate = self
    }
    
    func getData(query: String) {
        searchApi.getSearch(query: query)
    }
    
}

// MARK: - CoreApiDelegate
extension SearchViewModel: CoreApiDelegate {
    
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        do {

            let data = try JSONDecoder().decode(SearchModel.self, from: data)
            
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
