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
    private let categoryLabel = UILabel()
    private let productList: [CategoryCellCollectionViewCell.ViewModel] = [
        .init(image: UIImage(named: "susi"), title: "Суси", subtitle: "14"),
        .init(image: UIImage(named: "susi"), title: "Роллы", subtitle: "7"),
        .init(image: UIImage(named: "susi"), title: "Гунканы", subtitle: "30"),
        .init(image: UIImage(named: "susi"), title: "Сашими", subtitle: "5")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.greyColor
        
        addSubviews()
        setupSubviews()
        setupConstraints()
        categoriesCollectionView.configureCategoryList(productList: productList)
    }
    
    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(categoriesCollectionView)
        view.addSubview(categoryLabel)
    }
    
    private func setupSubviews() {
        categoriesCollectionView.backgroundColor = .clear
        
        categoryLabel.textColor = .white
        categoryLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 35.0)
    }
    
    private func setupConstraints() {
        [headerView, categoriesCollectionView, categoryLabel].forEach {
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
    }
}

