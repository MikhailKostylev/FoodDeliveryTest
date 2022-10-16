//
//  ProductTableViewCell.swift
//  FoodDeliveryTest
//
//  Created by Mikhail Kostylev on 15.10.2022.
//

import UIKit

final class ProductTableViewCell: UITableViewCell {

    static let id = String(describing: ProductTableViewCell.self)
        
    public var image: UIImage? = UIImage() {
        didSet {
            productImage.image = image
        }
    }
    
    public var name = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    public var descriptionText: String? = "" {
        didSet {
            descriptionLabel.text = descriptionText
        }
    }
    
    private var productImage = UIImageView()
    private var nameLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var priceButton = UIButton()
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setup()
        layout()
    }
    
    // MARK: - Public
    
    public func setButtonTitle(coast: Int, _ id: Int) {
        if id == 1 {
            priceButton.setTitle("от \(coast) р", for: .normal)
        } else {
            priceButton.setTitle("\(coast) р", for: .normal)
        }
    }
    
    // MARK: - Private
    
    private func setup() {
        productImage.contentMode = .scaleAspectFit
        productImage.clipsToBounds = true
        
        nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        nameLabel.numberOfLines = 2
        nameLabel.textColor = .black
        
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = R.Color.description
        
        priceButton.layer.cornerRadius = 6.0
        priceButton.layer.borderWidth = 1.0
        priceButton.layer.borderColor = R.Color.activeIcon.cgColor
        priceButton.setTitle("от 345 р", for: .normal)
        priceButton.setTitleColor(R.Color.activeIcon, for: .normal)
        priceButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
    }
    
    private func layout() {
        addSubview(productImage)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(priceButton)
        
        productImage.prepareForAutoLayout()
        nameLabel.prepareForAutoLayout()
        descriptionLabel.prepareForAutoLayout()
        priceButton.prepareForAutoLayout()
        
        let constraints = [
            productImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            productImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            productImage.widthAnchor.constraint(equalToConstant: 132),
            productImage.heightAnchor.constraint(equalToConstant: 132),
            productImage.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10),
    
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 32),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            priceButton.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 16),
            priceButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            priceButton.widthAnchor.constraint(equalToConstant: 87),
            priceButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
