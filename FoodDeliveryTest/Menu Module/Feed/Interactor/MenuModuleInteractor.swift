//
//  MenuModuleInteractor.swift
//  FoodDeliveryTest
//
//  Created by Mikhail Kostylev on 15.10.2022.
//

import UIKit

protocol MenuModuleInteractorOutput {
    func reloadData()
}

final class MenuModuleInteractor: NetworkService {
    
    private var interactorOutput: MenuModuleInteractorOutput?
    
    private var entity: Info? {
        didSet {
            interactorOutput?.reloadData()
        }
    }
    
    init(interactorOutput: MenuModuleInteractorOutput) {
        self.interactorOutput = interactorOutput
    }
    
    private func setOutput(interactorOutput: MenuModuleInteractorOutput) {
        self.interactorOutput = interactorOutput
    }
}

// MARK: - Interactor Input

extension MenuModuleInteractor: MenuModuleInteractorInput {
    func getAllProducts() -> Info? {
        return entity
    }
    
    func getRequestForAllProducts() {
        request(path: R.String.Network.path) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                guard let products = try? JSONDecoder().decode(Info.self, from: data) else {
                    return
                }
                self.entity = products
                for i in 0..<self.entity!.items.count {
                    UIImage.loadImage(from: self.entity!.items[i].urlImage, completion: { image in
                        self.entity!.items[i].image = image
                    })
                }
                break
            case .failure(_):
                print("error")
            }
        }
    }
    
    func getCountOfProducts() -> Int {
        return (entity == nil) ? 5 : entity!.items.count
    }
    
    func getCountCellsHigher(_ section: Int) -> Int {
        guard entity != nil else {
            return 0
        }
        var count = 0
        for i in 0..<entity!.items.count {
            if entity!.items[i].idCategory == section {
                break
            }
            count += 1
        }
        return count
    }
    
    func defineCategory(_ id: Int) -> Int {
        guard let entity = entity?.items else {
            return 1
        }
        for i in entity {
            if i.id == id {
                return i.idCategory
            }
        }
        return 1
    }
}
