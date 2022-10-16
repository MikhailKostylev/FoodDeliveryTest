//
//  ImageLoader.swift
//  FoodDeliveryTest
//
//  Created by Mikhail Kostylev on 15.10.2022.
//

import UIKit

final class ImageLoader {
    static func loadImage(from url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            }
        }
        .resume()
    }
}
