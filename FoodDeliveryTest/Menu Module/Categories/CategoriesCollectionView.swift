//
//  CategoriesCollectionView.swift
//  FoodDeliveryTest
//
//  Created by Mikhail Kostylev on 15.10.2022.
//

import UIKit

protocol CategoriesOutput: AnyObject {
    func scrollToRow(name: String)
}

final class CategoriesCollectionView: UICollectionView {
    
    private var items = [String]()
    private var scrollView = UIScrollView()
    private weak var categoriesOutput: CategoriesOutput?
    
    init(items: [String], frame: CGRect) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: flowLayout)
        
        self.items = items
        self.frame = frame
        
        self.setupCollection()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Public
    
    public func setOutput(categoriesOutput: CategoriesOutput) {
        self.categoriesOutput = categoriesOutput
    }
    
    public func copyCategories(isTapped: Bool) -> CategoriesCollectionView {
        let copy = CategoriesCollectionView(items: items, frame: frame)
        let activeCell = self.indexPathsForSelectedItems![0]
        copy.scrollToItem(at: activeCell, at: .centeredHorizontally, animated: false)
        copy.backgroundColor = R.Color.background
        copy.selectItem(at: activeCell, animated: false, scrollPosition: .centeredHorizontally)
        if !isTapped {
            copy.contentOffset = scrollView.contentOffset
        }
        return copy
    }
    
    public func changeValue(_ copy: CategoriesCollectionView, isTapped: Bool) {
        let activeCell = copy.indexPathsForSelectedItems![0]
        scrollToItem(at: activeCell, at: .centeredHorizontally, animated: false)
        selectItem(at: activeCell, animated: false, scrollPosition: .centeredHorizontally)
        if !isTapped {
            contentOffset = copy.scrollView.contentOffset
        }
    }
    
    // MARK: - Private
    
    private func setupCollection() {
        self.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: CategoryCollectionCell.id)
        showsHorizontalScrollIndicator = false
        dataSource = self
        delegate = self
    }
}

// MARK: - DataSource, Delegate

extension CategoriesCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.id, for: indexPath) as? CategoryCollectionCell else { return UICollectionViewCell() }
        if collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
            cell.isSelected = true
        } else {
            cell.isSelected = false
        }
        cell.name = items[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = items[indexPath.row]
        label.sizeToFit()
        label.frame = CGRect(x: 0, y: 0, width: label.frame.width + 23, height: label.frame.height + 4)
        return CGSize(width: label.frame.width, height: 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionCell else {
            return
        }
        categoriesOutput?.scrollToRow(name: cell.name)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollView = scrollView
    }
}
