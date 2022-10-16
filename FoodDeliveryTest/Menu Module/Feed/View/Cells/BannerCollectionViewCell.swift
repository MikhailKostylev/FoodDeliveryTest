//
//  BannerCollectionViewCell.swift
//  FoodDeliveryTest
//
//  Created by Mikhail Kostylev on 15.10.2022.
//

import UIKit

final class BannerCollectionViewCell: UICollectionViewCell {

    static let id = String(describing: BannerCollectionViewCell.self)
        
    public var image = UIImage() {
        didSet {
            imageView.image = image
        }
    }
    
    private var imageView = UIImageView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Private
    
    private func setup() {
        backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
    }
    
    private func layout() {
        addSubview(imageView)
        imageView.prepareForAutoLayout()
        
        let constraints = [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

