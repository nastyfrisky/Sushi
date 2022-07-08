//
//  ViewController.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 07.07.2022.
//

import UIKit

final class ProductListViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let networkService = NetworkService()
    
    private let headerView = HeaderView()
    private let categoriesCollectionView = CategoriesCollectionView()
    private let dishesCollectionView = DishesCollectionView()
    private let categoryLabel = UILabel()
    private var productList: [CategoryCellCollectionViewCell.ViewModel] = []
    private var menuIDs: [String] = []
    private var dishList: [DishesCollectionViewCell.ViewModel] = []
    
    // MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.greyColor
        categoriesCollectionView.delegate = self
        
        addSubviews()
        setupSubviews()
        setupConstraints()
        categoriesCollectionView.configureCategoryList(productList: productList)
        dishesCollectionView.configureDishList(dishList: dishList)
        
        categoryLabel.text = ""
        
        updateCategories()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(categoriesCollectionView)
        view.addSubview(categoryLabel)
        view.addSubview(dishesCollectionView)
    }
    
    private func setupSubviews() {
        categoriesCollectionView.backgroundColor = .clear
        dishesCollectionView.backgroundColor = .clear
        
        categoryLabel.textColor = .white
        categoryLabel.font = Constants.fontBold35
    }
    
    private func setupConstraints() {
        [headerView, categoriesCollectionView, dishesCollectionView, categoryLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            headerView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            categoriesCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: categoriesCollectionView.bottomAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            dishesCollectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            dishesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dishesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dishesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            if cell.isSelected == true {
                categoryLabel.text = productList[indexPath.item].title
            }
        }
        
        updateDishes(menuID: menuIDs[indexPath.item])
    }
}

// MARK: - Network

extension ProductListViewController {
    private func updateCategories() {
        networkService.loadCategories { [weak self] result in
            switch result {
            case let .success(categories):
                self?.setup(categories: categories)
            case let .failure(error):
                self?.handleError(error)
            }
        }
    }
    
    private func updateDishes(menuID: String) {
        networkService.loadDishes(menuID: menuID) { [weak self] result in
            switch result {
            case let .success(dishes):
                self?.setup(dishes: dishes)
            case let .failure(error):
                self?.handleError(error)
            }
        }
        
        setup(dishes: [])
    }
    
    private func setup(categories: [Category]) {
        productList = categories.map {
            menuIDs.append($0.menuID)
            return .init(
                imageProvider: makeImageProvider(image: $0.image),
                title: $0.name,
                subtitle: String($0.subMenuCount)
            )
        }
        
        categoriesCollectionView.configureCategoryList(productList: productList)
        categoriesCollectionView.reloadData()
    }
    
    private func setup(dishes: [Dish]) {
        dishList = dishes.map {
            .init(
                imageProvider: makeImageProvider(image: $0.image),
                title: $0.name,
                subtitle: $0.content,
                price: $0.price,
                weight: $0.weight ?? "",
                isSpicy: $0.spicy == "Y"
            )
        }
        
        dishesCollectionView.configureDishList(dishList: dishList)
        dishesCollectionView.reloadData()
    }
    
    private func makeImageProvider(image: String) -> ImageProviderProtocol? {
        guard let url = networkService.makeImageURL(image) else {
            return nil
        }
        
        return ImageProviderUrl(url: url)
    }
    
    private func handleError(_ error: NetworkService.LoadingError) {
        let message: String
        switch error {
        case .wrongData: message = "Ошибка в работе сервиса"
        case .noData: message = "Проверьте подключение к интернету"
        }
        
        let alert = UIAlertController(title: "Ошибка!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ок", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
