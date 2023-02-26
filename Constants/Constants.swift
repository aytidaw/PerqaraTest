//
//  Constant.swift
//  PerqaraTest
//
//  Created by aditya  on 25/02/23.
//

import Foundation
import UIKit

struct Constants {

    static let APIKEY = "key=7c598f0ba24b42b7a0ce4bc2011f3bf2"
    
    enum Colors: String {
        case AppBaseDarkBlueColor = "#303e4e"
        case LightGray = "#E2E2E2"
    
        func color() -> UIColor {
            return UIColor(rgba: self.rawValue)
        }
    }

    enum Fonts: String {
        case Regular = "OpenSans"
        case Bold = "OpenSans-Bold"
        case Light = "OpenSans-Light"
        case Italic = "OpenSans-Italic"
        case ExtraBold = "OpenSans-ExtraBold"
        case SemiBold = "OpenSans-Semibold"
        case SemiBoldItalic = "OpenSans-SemiboldItalic"
        case PoppinsSemiBold = "Poppins-SemiBold"
        case PoppinsRegular = "Poppins-Regular"
        case PoppinsMedium = "Poppins-Medium"

        func font(_ size: CGFloat) -> UIFont {
            if let font = UIFont(name: self.rawValue, size: size) {
                return font
            }
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    enum Images: String {
        case TabBarOne = "home"
        case TabBarTwo = "booking"
        case TabBarOneSelected = "homeSelected"
        case TabBarTwoSelected = "bookingSelected"
    }
    
    enum TabbarName: String {
        case TabbarOne = "Home"
        case TabbarTwo = "Favorite"
    }
}


struct ConstantApi {
    static let BASE_URL = "https://api.rawg.io"
    static let HOME_API = "/api/games"
}

public func server(with api: String) -> String {
    let serverURL = "\(ConstantApi.BASE_URL)\(api)"
    return serverURL
}
