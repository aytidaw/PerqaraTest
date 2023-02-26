//
//  HomeApi.swift
//  PerqaraTest
//
//  Created by aditya  on 26/02/23.
//

import Foundation

class HomeApi: CoreApi {
    override init () {
        super.init()
        self.method = .get
    }
    
    func getData(page: Int, pageSize: Int) {
        let urlString = ConstantApi.HOME_API + "?" + Constants.APIKEY + "&page=\(page)" + "&page_size=\(pageSize)"
        self.URL = server(with: urlString)
        getRequest()
    }
}
