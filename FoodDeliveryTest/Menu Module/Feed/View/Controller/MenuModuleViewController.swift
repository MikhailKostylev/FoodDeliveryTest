//
//  MenuModuleViewController.swift
//  FoodDeliveryTest
//
//  Created by Mikhail Kostylev on 15.10.2022.
//

import UIKit

protocol MenuModuleViewOutput: AnyObject {
    func getRequestForAllProducts()
    func getAllProducts() -> Info?
    func getCountOfProducts() -> Int
    func getCountCellsHigher(_ section: Int) -> Int
    func defineCategory(_ id: Int) -> Int
}

final class MenuModuleViewController: UIViewController {
    
    private let tableView = UITableView()
    private var copyCategories: UIView?
    private var categories: CategoriesCollectionView?
    
    private var viewOutput: MenuModuleViewOutput?
    
    private var isViewWithCategories = false
    private var isTappedOnCategories = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupNavigationBar()
        layout()
        viewOutput?.getRequestForAllProducts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.animateTableView()
    }
    
    // MARK: - Public
    
    public func setViewOutput(viewOutput: MenuModuleViewOutput) {
        self.viewOutput = viewOutput
    }
    
    // MARK: - Private
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(BannersTableViewCell.self, forCellReuseIdentifier: BannersTableViewCell.id)
        tableView.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.id)
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.id)
        
        tableView.backgroundColor = R.Color.background
        tableView.allowsSelection = false
    }
    
    private func layout() {
        view.addSubview(tableView)
        tableView.prepareForAutoLayout()
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = createCustomButtonFromBarButtonItem(
            title: R.String.Cities.moscow,
            image: R.Image.arrow,
            selector: #selector(leftButtonTapped),
            reverse: true
        )
        navigationController?.navigationBar.backgroundColor = R.Color.background
        navigationController?.navigationBar.barTintColor = R.Color.background
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc private func leftButtonTapped(sender: UIButton) {
        print("Bar button tapped")
    }
    
    private func createCustomButtonFromBarButtonItem(
        title: String,
        image: UIImage,
        selector: Selector,
        reverse: Bool
    ) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        let titleString = reverse ?  title + " " : " " + title
        button.setTitle(titleString, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.tintColor = R.Color.cityText
        button.addTarget(self, action: selector, for: .touchUpInside)
        if reverse {
            button.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            button.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            button.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        button.sizeToFit()
        let barItem = UIBarButtonItem(customView: button)
        
        return barItem
    }
    
    private func setupRoundedCell(cell: UITableViewCell) {
        let path = UIBezierPath(
            roundedRect: CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: view.frame.width, height: cell.frame.height),
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 20, height:  20)
        )
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        cell.layer.mask = maskLayer
        cell.layer.masksToBounds = true
        cell.separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
    }
    
    private func changingCategoriesWhenMoving() -> IndexPath {
        let visibleCells = tableView.indexPathsForVisibleRows
        let lastCell = (visibleCells?.last?.row ?? 0) - 3
        let category = viewOutput!.defineCategory(lastCell) - 1
        return IndexPath(row: category, section: 0)
    }
}

// MARK: - TableView DataSource

extension MenuModuleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewOutput = viewOutput else { return 0 }
        return 3 + viewOutput.getCountOfProducts()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannersTableViewCell.id) else {
                return UITableViewCell()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.id) as? CategoriesTableViewCell else {
                return UITableViewCell()
            }
            cell.collectionView.setOutput(categoriesOutput: self)
            return cell
        case 2:
            let cell = UITableViewCell()
            cell.backgroundColor = .white
            setupRoundedCell(cell: cell)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.id) as? ProductTableViewCell else {
                return UITableViewCell()
            }
            guard let entity = viewOutput?.getAllProducts() else {
                return cell
            }
            
            let item = entity.items[indexPath.row - 3]
            cell.image = item.image
            cell.name = item.name
            cell.descriptionText = item.itemDescription
            cell.setButtonTitle(coast: item.minSum, item.idCategory)
            return cell
        }
    }
}

// MARK: - TableView Delegate

extension MenuModuleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150.0
        }
        else if indexPath.row == 1 {
            return 52.0
        }
        else if indexPath.row == 2 {
            return 14.0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indexPath = changingCategoriesWhenMoving()
        guard let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? CategoriesTableViewCell else {
            if !isTappedOnCategories {
                categories?.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                categories?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            return
        }
        if !isTappedOnCategories {
            cell.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            categories?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        let navigationViewHeight = navigationController!.navigationBar.frame.height
        let temp = navigationViewHeight + (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 20)
        
        if scrollView.contentOffset.y >= cell.frame.origin.y && !isViewWithCategories {
            copyCategories = UIView()
            copyCategories!.frame = CGRect(x: 0, y: temp, width: cell.frame.width, height: cell.frame.height)
            copyCategories!.backgroundColor = R.Color.background
            DispatchQueue.main.async {
                self.tableView.contentInset = UIEdgeInsets(top: self.copyCategories!.frame.height, left: 0, bottom: 0, right: 0)
            }
            categories = cell.collectionView.copyCategories(isTapped: isTappedOnCategories)
            categories!.setOutput(categoriesOutput: self)
            copyCategories!.addSubview(categories!)
            view.addSubview(copyCategories!)
            isViewWithCategories = true
            isTappedOnCategories = false
            
        } else if scrollView.contentOffset.y < cell.frame.origin.y && isViewWithCategories {
            copyCategories?.removeFromSuperview()
            if copyCategories != nil {
                cell.collectionView.changeValue(copyCategories!.subviews[0] as! CategoriesCollectionView, isTapped: isTappedOnCategories)
            }
            isViewWithCategories = false
            self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
}

// MARK: - View Input

extension MenuModuleViewController: MenuModuleViewInput {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - Categories Output

extension MenuModuleViewController: CategoriesOutput {
    func scrollToRow(name: String) {
        var row = 0
        switch name {
        case "Пицца":
            row = 0
            break
        case "Комбо":
            row = 3 + viewOutput!.getCountCellsHigher(2)
            break
        case "Десерты":
            row = 3 + viewOutput!.getCountCellsHigher(3)
            break
        case "Напитки":
            row = 3 + viewOutput!.getCountCellsHigher(4)
            break
        case "Другие товары":
            row = 3 + viewOutput!.getCountCellsHigher(5)
            break
        default:
            row = 3
        }
        
        self.isTappedOnCategories = true
        var sum: CGFloat = 0.0
        for i in 0..<row {
            let indexPath = IndexPath(row: i, section: 0)
            let cell1 = self.tableView.cellForRow(at: indexPath)
            sum += cell1?.frame.height ?? 0.0
        }
        
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? CategoriesTableViewCell
        
        if sum > view.frame.height {
            if cell == nil {
                self.tableView.contentInset = UIEdgeInsets(top: self.copyCategories!.frame.height, left: 0, bottom: 0, right: 0)
            } else {
                self.tableView.contentInset = UIEdgeInsets(top: cell!.frame.height, left: 0, bottom: 0, right: 0)
            }
        }
        
        self.tableView.scrollToRow(at: IndexPath(row: row, section: 0), at: .top, animated: true)
    }
}
