//
//  MenuModuleEntity.swift
//  FoodDeliveryTest
//
//  Created by Mikhail Kostylev on 15.10.2022.
//

import UIKit

struct Info: Codable {
    var items: [Item]
}

struct Item: Codable {
    let id: Int
    let name: String
    let idCategory: Int
    let itemDescription: String?
    let minSum: Int
    let urlImage: String
    let nameCategory: [NameCategory]
    var image: UIImage?

    enum CodingKeys: String, CodingKey {
        case id, name, idCategory
        case itemDescription = "description"
        case minSum, urlImage, nameCategory
    }
}

struct NameCategory: Codable {
    let nameCategory: String
}
