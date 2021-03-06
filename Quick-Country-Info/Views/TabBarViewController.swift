//
//  TabBarViewController.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UINavigationController(rootViewController: ContinentsViewController())
        let vc2 = UINavigationController(rootViewController: SearchCountryViewController())

        vc1.tabBarItem.image = UIImage(systemName: "globe.asia.australia")
        vc2.tabBarItem.image = UIImage(systemName: "text.magnifyingglass")

        vc1.title = "Continents"
        vc2.title = "Search Country"
        
        tabBar.tintColor = UIColor(named: "NavBarColor") ?? .systemBlue
                
        let appearance = tabBar.standardAppearance
        appearance.configureWithDefaultBackground()
        //appearance.backgroundColor = UIColor(named: "NavBarColor") ?? .systemBlue
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        } else {
            tabBar.standardAppearance = appearance
        }
        
        setViewControllers([vc1, vc2], animated: true)
    }
}
