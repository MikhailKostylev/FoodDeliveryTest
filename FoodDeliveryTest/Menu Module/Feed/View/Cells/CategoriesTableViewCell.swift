//
//  CategoriesTableViewCell.swift
//  FoodDeliveryTest
//
//  Created by Mikhail Kostylev on 15.10.2022.
//

import UIKit

final class CategoriesTableViewCell: UITableViewCell {
    
    static let id = String(describing: CategoriesTableViewCell.self)
    
    public var collectionView = CategoriesCollectionView(
        items: R.String.Categories.categories,
        frame: CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 56)
    )
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setup()
    }
    
    private func setup() {
        collectionView.dataSource = collectionView
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .bottom)
        collectionView.collectionView(collectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        addSubview(collectionView)
        
        backgroundColor = R.Color.background
        collectionView.backgroundColor = R.Color.background        
    }
}

