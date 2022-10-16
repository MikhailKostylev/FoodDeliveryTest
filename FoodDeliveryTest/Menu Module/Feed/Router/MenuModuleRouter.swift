//
//  MenuModuleRouter.swift
//  FoodDeliveryTest
//
//  Created by Mikhail Kostylev on 15.10.2022.
//

import UIKit

final class MenuModuleRouter {
    
    private var view: MenuModuleViewController
    private var presenter: MenuModulePresenter?
        
    init() {
        view = MenuModuleViewController()
        presenter = MenuModulePresenter(viewInput: view)
        view.setViewOutput(viewOutput: presenter!)
    }
        
    public func getView() -> UIViewController {
        return view
    }
}
