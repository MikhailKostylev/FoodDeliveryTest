//
//  CategoryCollectionCell.swift
//  FoodDeliveryTest
//
//  Created by Mikhail Kostylev on 15.10.2022.
//

import UIKit

final class CategoryCollectionCell: UICollectionViewCell {
    
    static let id = String(describing: CategoryCollectionCell.self)
        
    public var name = "" {
        didSet {
            categoryLabel.text = name
        }
    }
    
    private var color = R.Color.activeIcon {
        didSet {
            categoryLabel.textColor = color
        }
    }
    
    private let categoryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = R.Color.background
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                color = R.Color.activeIcon
                categoryLabel.font = .systemFont(ofSize: 13, weight: .bold)
                backgroundColor = R.Color.activeIcon.withAlphaComponent(0.2)
                layer.cornerRadius = 15
                layer.borderWidth = 0.0
            } else {
                color = R.Color.activeIcon.withAlphaComponent(0.4)
                categoryLabel.font = .systemFont(ofSize: 13, weight: .medium)
                backgroundColor = R.Color.background
                layer.borderWidth = 1
                layer.cornerRadius = 15
                layer.borderColor = R.Color.activeIcon.withAlphaComponent(0.4).cgColor
            }
        }
    }
    
    private func setup() {
        categoryLabel.font = .systemFont(ofSize: 13, weight: .medium)
        categoryLabel.textAlignment = .center
    }
    
    private func layout() {
        addSubview(categoryLabel)
        categoryLabel.prepareForAutoLayout()
        
        let constraints = [
            categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoryLabel.widthAnchor.constraint(equalTo: widthAnchor),
            categoryLabel.heightAnchor.constraint(equalTo: heightAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
