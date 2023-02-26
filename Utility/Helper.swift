//
//  Helper.swift
//  PerqaraTest
//
//  Created by aditya  on 26/02/23.
//

import UIKit
import NVActivityIndicatorView

private var activityIndicator : NVActivityIndicatorView!
private var containerIndicator : UIView!

public class Helper {
    
    class func defaultBlockLoading(_ withMessage: String = "") {
        let activityData = ActivityData(size: CGSize(width: 30, height: 30),
                                        message: withMessage,
                                        messageFont: nil,
                                        type: .ballClipRotate,
                                        color: nil,
                                        padding: nil,
                                        displayTimeThreshold: 2,
                                        minimumDisplayTime: 2,
                                        backgroundColor: nil,
                                        textColor: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    
    class func stopLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        if containerIndicator != nil {
            containerIndicator.removeFromSuperview()
        }
    }
}
