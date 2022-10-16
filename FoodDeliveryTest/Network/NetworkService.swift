//
//  NetworkService.swift
//  FoodDeliveryTest
//
//  Created by Mikhail Kostylev on 15.10.2022.
//

import Foundation

class NetworkService {
    func request(path: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let urlForRequest = URL(string: R.String.Network.url + path) else { return }
        
        let task = URLSession.shared.dataTask(with: urlForRequest) { data, response, error in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
