//
//  ViewController.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 07.07.2022.
//

import UIKit

final class ProductListViewController: UIViewController {
    
    private let headerView = HeaderView()
    private let categoriesCollectionView = CategoriesCollectionView()
    private let dishesCollectionView = DishesCollectionView()
    private let categoryLabel = UILabel()
    private let productList: [CategoryCellCollectionViewCell.ViewModel] = [
        .init(image: UIImage(named: "susi"), title: "Суси", subtitle: "14"),
        .init(image: UIImage(named: "susi"), title: "Роллы", subtitle: "7"),
        .init(image: UIImage(named: "susi"), title: "Гунканы", subtitle: "30"),
        .init(image: UIImage(named: "susi"), title: "Сашими", subtitle: "5")
    ]
    private let dishList: [DishesCollectionViewCell.ViewModel] = [
        .init(
            image: UIImage(named: "susi"),
            title: "Магура",
            subtitle: "Тунец",
            price: "80",
            weight: "40",
            spicyImage: nil
        ),
        .init(
            image: UIImage(named: "susi"),
            title: "Магура",
            subtitle: "Тунец, соус спайси",
            price: "100",
            weight: "50",
            spicyImage: UIImage(named: "spicy")
        ),
        .init(
            image: UIImage(named: "susi"),
            title: "Сливочная икура",
            subtitle: "Сыр сливочный, икра лосося",
            price: "130",
            weight: "45",
            spicyImage: nil
        ),
        .init(
            image: UIImage(named: "susi"),
            title: "Сливочная икура",
            subtitle: "Сыр сливочный, икра лосося",
            price: "130",
            weight: "45",
            spicyImage: nil
        ),
        .init(
            image: UIImage(named: "susi"),
            title: "Магура",
            subtitle: "Тунец",
            price: "80",
            weight: "40",
            spicyImage: nil
        ),
        .init(
            image: UIImage(named: "susi"),
            title: "Магура",
            subtitle: "Тунец, соус спайси",
            price: "100",
            weight: "50",
            spicyImage: UIImage(named: "spicy")
        ),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.greyColor
        categoriesCollectionView.delegate = self
        
        addSubviews()
        setupSubviews()
        setupConstraints()
        categoriesCollectionView.configureCategoryList(productList: productList)
        dishesCollectionView.configureDishList(dishList: dishList)
        
        
    }
    
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
        categoryLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 35.0)
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

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            if cell.isSelected == true {
                categoryLabel.text = productList[indexPath.item].title
            }
        }
    }
}
