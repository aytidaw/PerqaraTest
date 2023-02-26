//
//  SearchApi.swift
//  PerqaraTest
//
//  Created by aditya  on 26/02/23.
//

import Foundation

class SearchApi: CoreApi {
    
    var searchString: String!
    
    override init () {
        super.init()
        self.method = .get
    }
    
    func getSearch(query: String) {
        let urlString = ConstantApi.HOME_API + "?search=\(query)" + "&" + Constants.APIKEY
        self.URL = server(with: urlString)
        getRequest()
    }
    
}
