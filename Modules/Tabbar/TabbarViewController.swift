//
//  TabbarViewController.swift
//  PerqaraTest
//
//  Created by aditya  on 25/02/23.
//

import Foundation
import UIKit


class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
//    var incomingArray = [BaseTabbar]()
    var arrayOfController = [UIViewController]()
    var customTabbarView = UIView(frame: .zero)
    var previousIndex = 0
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setupTabbar()
    }
        
    
    @objc func setupTabbar() {
        
        self.tabBar.backgroundColor = Constants.Colors.LightGray.color()
       //
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: Constants.Fonts.PoppinsMedium.font(12)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: Constants.Fonts.PoppinsMedium.font(12), NSAttributedString.Key.foregroundColor: Constants.Colors.AppBaseDarkBlueColor.color()], for: .selected)

        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
        let vc1 = HomeViewController.loadFromNib()
        let vc2 = FavoriteViewController.loadFromNib()
        
        let homeNav = UINavigationController(rootViewController: vc1)
        homeNav.isNavigationBarHidden = true
        vc1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "icn_homeTabbar"), tag: 0)
        
        let favNav = UINavigationController(rootViewController: vc2)
        favNav.isNavigationBarHidden = true
        vc2.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "icn_love_normal"), tag: 1)
        
        self.viewControllers = [homeNav, favNav]
        
        tabBar.isTranslucent = false
    }
    
}

    
/*
class TabbarViewController: UITabBarController {
    
    var incomingArray = [BaseTabbar]()
    var arrayOfController = [UIViewController]()
    var customTabbarView = UIView(frame: .zero)
    var previousIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabbar()
        setupCustomTabbar()
        createTabsFromArray(array: createTab())
        viewControllers = arrayOfController
    }
    
    func setupCustomTabbarFrame() {
        let height = self.view.safeAreaInsets.bottom + 66
        
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = height
        tabFrame.origin.y = self.view.frame.size.height - height
        
        self.tabBar.frame = tabFrame
        self.tabBar.setNeedsLayout()
        self.tabBar.layoutIfNeeded()
        
        customTabbarView.frame = tabBar.frame
    }
    
    func setupTabbar() {
        self.tabBar.backgroundColor = Constants.Colors.LightGray.color()
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -8)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: Constants.Fonts.PoppinsMedium.font(12)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: Constants.Fonts.PoppinsMedium.font(12), NSAttributedString.Key.foregroundColor: Constants.Colors.AppBaseDarkBlueColor.color()], for: .selected)
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
    func setupCustomTabbar() {
        customTabbarView.frame = tabBar.frame
        
        customTabbarView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        customTabbarView.layer.shadowOffset = CGSize(width: 0, height: -2)
        customTabbarView.layer.shadowOpacity = 1
        customTabbarView.layer.shadowRadius = 12
        customTabbarView.layer.masksToBounds = false
        
        view.addSubview(customTabbarView)
        view.bringSubviewToFront(tabBar)
    }
    
    private func createTabsFromArray(array: [BaseTabbar]) {
        for tab in array {
            let vc = createController(title: tab.title,
                                      imageName: tab.imageName,
                                      selectedImage: tab.selectedImage,
                                      controller: tab.controller,
                                      tag: tab.selectedIndex)
            arrayOfController.append(vc)
        }
    }
    
    private func createController(title: String, imageName: String, selectedImage: String, controller: UIViewController, tag: Int) -> UIViewController {
        
        let viewController = controller
        
        controller.tabBarItem.title = title
        controller.tabBarItem.tag = tag
        controller.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        
        return viewController
    }
    
    func createTab() -> [BaseTabbar] {

        var arrayOfTab = [BaseTabbar]()

        let vc1 = HomeViewController.loadFromNib()
        let vc2 = FavoriteViewController.loadFromNib()
    
        let tabOne = BaseTabbar(title: Constants.TabbarName.TabbarOne.rawValue,
                                imageName: Constants.Images.TabBarOne.rawValue,
                                selectedImage: Constants.Images.TabBarOneSelected.rawValue,
                                controller: vc1,
                                selectedIndex: 0)
        
        let tabTwo = BaseTabbar(title: Constants.TabbarName.TabbarTwo.rawValue,
                                imageName: Constants.Images.TabBarTwo.rawValue,
                                selectedImage: Constants.Images.TabBarTwoSelected.rawValue,
                                controller: vc2,
                                selectedIndex: 1)

        arrayOfTab = [tabOne, tabTwo]

        return arrayOfTab
    }
}
*/
