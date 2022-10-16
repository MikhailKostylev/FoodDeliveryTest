//
//  Resources.swift
//  FoodDeliveryTest
//
//  Created by Mikhail Kostylev on 15.10.2022.
//

import UIKit

typealias R = Resources

enum Resources {
    enum String {
        enum Network {
            static let url = "https://apex.oracle.com/pls/apex/dashashevchenkoapps/testapi/"
            static let path = "products"
        }
        
        enum TabBar {
            static let menu = "Меню"
            static let contacts = "Контакты"
            static let profile = "Профиль"
            static let basket = "Корзина"
        }
        
        enum Cities {
            static let moscow = "Москва"
        }
        
        enum Categories {
            static let categories = [
                "Пицца",
                "Комбо",
                "Десерты",
                "Напитки",
                "Другие товары"
            ]
        }
    }
    
    enum Color {
        static let icon = UIColor.init(hexString: "#C3C4C9")
        static let activeIcon = UIColor.init(hexString: "#FD3A69")
        static let cityText = UIColor.init(hexString: "#222831")
        static let background = UIColor.init(hexString: "#F3F5F9")
        static let description = UIColor.init(hexString: "#AAAAAD")
    }
    
    enum Icons {
        enum TabBar {
            static let menu = UIImage(named: "menu")!
            static let contacts = UIImage(named: "contacts")!
            static let profile = UIImage(named: "profile")!
            static let basket = UIImage(named: "basket")!
        }
    }
    
    enum Image {
        static let arrow = UIImage(named: "arrow")!
        static let banners = [
            UIImage(named: "banner1")!,
            UIImage(named: "banner2")!,
            UIImage(named: "banner3")!,
            UIImage(named: "banner4")!
        ]
    }
}
