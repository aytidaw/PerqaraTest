//
//  UIViewController.swift
//  PerqaraTest
//
//  Created by aditya  on 26/02/23.
//

import UIKit

extension UIViewController {

    func setNavTitle(withTitle: String, withBackButton: Bool = true) {
        self.navigationItem.title = withTitle
        self.navigationController?.navigationBar.isTranslucent = false
        
        let backImage = UIImage(named: "backLogo")
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.tintColor = .black
        
        if withBackButton {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(backTapped))
        } else {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc func backTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func showPopupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
         for (index, title) in actionTitles.enumerated() {
             let action = UIAlertAction(title: title, style: .default, handler: actions[index])
             alert.addAction(action)
         }
         self.present(alert, animated: true, completion: nil)
     }
}

