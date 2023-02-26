//
//  DetailApi.swift
//  PerqaraTest
//
//  Created by aditya  on 26/02/23.
//

import Foundation

class DetailApi: CoreApi {
    
    override init () {
        super.init()
        self.method = .get
    }
    
    func getData(id: Int) {
        let urlString = ConstantApi.HOME_API + "/\(id)" + "?" + Constants.APIKEY
        self.URL = server(with: urlString)
        getRequest()
    }
}
