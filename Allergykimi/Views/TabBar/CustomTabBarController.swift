//
//  CustomTabBarController.swift
//  Allergykimi
//
//  Created by 은서우 on 3/11/24.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    let homeNavController = UINavigationController(rootViewController: HomeViewController())
    let mapNavController = UINavigationController(rootViewController: ViewController())
    let myPageNavController = UINavigationController(rootViewController: MyPageViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 0 : 맵뷰
        let mapTabBarItem = UITabBarItem(title: nil, image:  UIImage(systemName: "pill"), selectedImage: UIImage(systemName: "pill.fill"))
        mapTabBarItem.tag = 0
        mapNavController.tabBarItem = mapTabBarItem
        // 1 : 홈뷰
        let homeTabBarItem = UITabBarItem(title: nil, image:  UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        homeTabBarItem.tag = 1
        homeNavController.tabBarItem = homeTabBarItem
        // 2 : 마이페이지 뷰
        let myPageTabBarItem = UITabBarItem(title: nil, image:  UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        myPageTabBarItem.tag = 2
        myPageNavController.tabBarItem = myPageTabBarItem
        
        self.viewControllers = [mapNavController, homeNavController, myPageNavController]
        
    }
    
    
    
    
}
