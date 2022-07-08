//
//  TabbarViewController.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 07.07.2022.
//

import UIKit

final class TabbarController: UITabBarController {
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.greyColor
        tabBar.backgroundColor = UIColor.black
        UITabBar.appearance().tintColor = UIColor.systemYellow
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        
        addTabs()
    }
    
    // MARK: - Private Methods
    
    private func setupVC(vc: UIViewController, imageName: String) {
        let icon = UITabBarItem(
            title: nil,
            image: UIImage(systemName: imageName),
            selectedImage: nil)
        vc.tabBarItem = icon
    }
    
    private func addTabs() {
        let firstVC = ProductListViewController()
        setupVC(vc: firstVC, imageName: "list.bullet")
        
        let secondVC = ShoppingCartViewController()
        setupVC(vc: secondVC, imageName: "bag")
        
        let thirdVC = ShoppingCartViewController()
        setupVC(vc: thirdVC, imageName: "info")
        
        let controllers = [firstVC, secondVC, thirdVC]
        self.viewControllers = controllers
    }
}

