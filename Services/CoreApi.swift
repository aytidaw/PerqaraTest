//
//  CoreApi.swift
//  PerqaraTest
//
//  Created by aditya  on 25/02/23.
//

import Foundation
import Alamofire

@objc protocol CoreApiDelegate {
    @objc func finish(interFace : CoreApi, responseHeaders : HTTPURLResponse, data : Data)
    @objc func failed(interFace : CoreApi, result : AnyObject)
}

class CoreApi : NSObject {
    var URL = ""
    var encoding: ParameterEncoding = URLEncoding.default
    weak var delegate : CoreApiDelegate?
    var method : HTTPMethod = .get
    var isAuthorization = true
    var contentType = "application/json"
    var imageUpload: UIImage = UIImage()
    
    func getRequest() {
        
        Alamofire.request(URL, method: method, parameters : getParam(), encoding: encoding, headers: getHeader()).responseJSON { response in

            print("Header >>> \(self.getHeader())")
            print("URL Request >>> \(String(describing: response.request))")  // original URL request
            print("statusCode >>> \(String(describing: response.response?.statusCode))\n\n")

            do{
                if let responseValue = response.result.value, !(responseValue is NSNull) {
                    let jsonData = try JSONSerialization.data(withJSONObject: responseValue, options: [])
                    let responseString = String(data: jsonData, encoding: .utf8)!

                    let paramjsonData = try JSONSerialization.data(withJSONObject: self.getParam(), options: [])
                    let paramString = String(data: paramjsonData, encoding: .utf8)!
                    print("Param >>> \(paramString)")
                    print("Response >>> \(responseString)\n\n")
                }

            } catch {}

            let statusCode = response.response?.statusCode

            print("statusCode \(String(describing: statusCode))")
            switch (statusCode) {

            case 200,201:

                guard let responseHeader = response.response else { return }
                guard let data = response.data else { return }
                self.success(responseHeaders: responseHeader, data: data)
            case 403:
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationTokenExpired"), object: nil, userInfo: nil)
            default:
                guard let data = response.data else { return }
                self.failed(data: data as AnyObject)

            }
        }

    }

    func getHeader() -> HTTPHeaders  {
        return ["accept": "application/json"]
    }

    func getParam() -> [String : Any]  {
         return [:]
     }

    func success(responseHeaders : HTTPURLResponse, data : Data) {
        delegate?.finish(interFace: self, responseHeaders : responseHeaders, data : data)
    }

    func failed(data : AnyObject) {
        delegate?.failed(interFace: self, result: data)
    }

}
