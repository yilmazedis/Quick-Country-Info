//
//  TabBarViewController.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import Foundation

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow

        let vc1 = UINavigationController(rootViewController: ContinentsViewController())
        let vc2 = UINavigationController(rootViewController: SearchCountryViewController())


        vc1.tabBarItem.image = UIImage(systemName: "globe.europe.africa.fill")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle.fill")


        vc1.title = "Continents"
        vc2.title = "Search Country"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2], animated: true)
    }
}
