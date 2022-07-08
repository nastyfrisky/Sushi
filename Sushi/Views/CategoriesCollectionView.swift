//
//  CategoriesCollectionView.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 07.07.2022.
//

import UIKit

final class CategoriesCollectionView: UICollectionView, UICollectionViewDataSource {
    
    // MARK: - Private Properties
    
    private var productList: [CategoryCellCollectionViewCell.ViewModel] = []
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero, collectionViewLayout: CategoriesCollectionView.createLayout())
        showsHorizontalScrollIndicator = false
        register(CategoryCellCollectionViewCell.self, forCellWithReuseIdentifier: "category")
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    static func createLayout() -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.itemSize = CGSize(width: 115, height: 130)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    func configureCategoryList(productList: [CategoryCellCollectionViewCell.ViewModel]) {
        self.productList = productList
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let optionalCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "category",
            for: indexPath
        ) as? CategoryCellCollectionViewCell
        
        let cell: CategoryCellCollectionViewCell = optionalCell ?? CategoryCellCollectionViewCell()
        
        cell.configure(viewModel: productList[indexPath.item])
        
        return cell
    }
}
