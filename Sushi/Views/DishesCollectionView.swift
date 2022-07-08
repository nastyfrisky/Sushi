//
//  DishesCollectionView.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 08.07.2022.
//

import UIKit

final class DishesCollectionView: UICollectionView, UICollectionViewDataSource {
    
    private var dishList: [DishesCollectionViewCell.ViewModel] = []
    
    init() {
        super.init(frame: .zero, collectionViewLayout: DishesCollectionView.createLayout())
        showsVerticalScrollIndicator = false
        register(DishesCollectionViewCell.self, forCellWithReuseIdentifier: "dish")
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createLayout() -> UICollectionViewFlowLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 30, right: 15)
        layout.itemSize = CGSize(width: 170, height: 200)
        layout.minimumLineSpacing = 40
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    func configureDishList(dishList: [DishesCollectionViewCell.ViewModel]) {
        self.dishList = dishList
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dishList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let optionalCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "dish",
            for: indexPath
        ) as? DishesCollectionViewCell
        
        let cell: DishesCollectionViewCell = optionalCell ?? DishesCollectionViewCell()
        
        cell.configure(viewModel: dishList[indexPath.item])
        
        return cell
    }
}

