//
//  TabBarController.swift
//  FoodDeliveryTest
//
//  Created by Mikhail Kostylev on 15.10.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
        
    private func generateNavigationController(
        title: String,
        image: UIImage,
        view: UIViewController
    ) -> UIViewController {
        view.tabBarItem.title = title
        view.tabBarItem.image = image
        return UINavigationController(rootViewController: view)
    }
    
    private func setupTabBar() {
        viewControllers = [
            generateNavigationController(
                title: R.String.TabBar.menu,
                image: R.Icons.TabBar.menu,
                view: MenuModuleRouter().getView()
            ),
            generateNavigationController(
                title: R.String.TabBar.contacts,
                image: R.Icons.TabBar.contacts,
                view: UIViewController()
            ),
            generateNavigationController(
                title: R.String.TabBar.profile,
                image: R.Icons.TabBar.profile,
                view: UIViewController()
            ),
            generateNavigationController(
                title: R.String.TabBar.basket,
                image: R.Icons.TabBar.basket,
                view: UIViewController()
            )
        ]
        
        tabBar.backgroundColor = .white
        tabBar.tintColor = R.Color.activeIcon
        tabBar.unselectedItemTintColor = R.Color.icon
    }
}
