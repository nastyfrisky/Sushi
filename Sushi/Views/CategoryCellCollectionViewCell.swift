//
//  CategoryCellCollectionViewCell.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 07.07.2022.
//

import UIKit

final class CategoryCellCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let imageView = ImageView()
    private let nameOfCategory = UILabel()
    private let numberOfGoods = UILabel()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Constants.lightGrayColor
        
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(imageView)
        addSubview(nameOfCategory)
        addSubview(numberOfGoods)
    }
    
    private func setupSubviews() {
        nameOfCategory.font = Constants.fontBold15
        numberOfGoods.font = Constants.font13
        
        nameOfCategory.textColor = .white
        numberOfGoods.textColor = .lightGray
        
        nameOfCategory.adjustsFontSizeToFitWidth = true
        nameOfCategory.lineBreakMode = .byClipping
        nameOfCategory.textAlignment = .center
        
        let view = UIView(frame: bounds)
        view.backgroundColor = Constants.violetColor
        selectedBackgroundView = view
        
        layer.cornerRadius = 7
        clipsToBounds = true
    }
    
    private func setupConstraints() {
        [imageView, nameOfCategory, numberOfGoods].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameOfCategory.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameOfCategory.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            nameOfCategory.widthAnchor.constraint(equalTo: widthAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            numberOfGoods.centerXAnchor.constraint(equalTo: centerXAnchor),
            numberOfGoods.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
    }
}

extension CategoryCellCollectionViewCell {
    
    struct ViewModel {
        let imageProvider: ImageProviderProtocol?
        let title: String
        let subtitle: String
    }
    
    func configure(viewModel: ViewModel) {
        imageView.provider = viewModel.imageProvider
        nameOfCategory.text = viewModel.title
        numberOfGoods.text = viewModel.subtitle + " товаров"
    }
}
