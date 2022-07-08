//
//  DishesCollectionViewCell.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 08.07.2022.
//

import UIKit

final class DishesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let imageView = ImageView()
    private let dishName = UILabel()
    private let compositionOfTheDish = UILabel()
    private let infoAboutTheDish = UILabel()
    
    private let spicyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "spicy")
        return imageView
    }()
    
    private let view = UIView()
    private let button = UIButton()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        view.addSubview(dishName)
        view.addSubview(compositionOfTheDish)
        view.addSubview(infoAboutTheDish)
        view.addSubview(spicyImage)
        view.addSubview(imageView)
        
        addSubview(view)
        addSubview(button)
    }
    
    private func setupSubviews() {
        dishName.font = Constants.fontBold15
        dishName.textColor = .white
        
        compositionOfTheDish.font = Constants.font13
        compositionOfTheDish.textColor = .lightGray
        compositionOfTheDish.numberOfLines = 2
        compositionOfTheDish.textAlignment = .center
        compositionOfTheDish.lineBreakStrategy = .hangulWordPriority
        
        button.backgroundColor = Constants.violetColor
        button.titleLabel?.font = Constants.font15
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("В корзину", for: .normal)
        
        view.backgroundColor = .black
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
    }
    
    private func setupConstraints() {
        [dishName, compositionOfTheDish, infoAboutTheDish, spicyImage, imageView, view, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            dishName.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            dishName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            compositionOfTheDish.topAnchor.constraint(equalTo: dishName.bottomAnchor, constant: 5),
            compositionOfTheDish.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            compositionOfTheDish.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            infoAboutTheDish.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10),
            infoAboutTheDish.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            spicyImage.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -10),
            spicyImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            spicyImage.heightAnchor.constraint(equalToConstant: 20),
            spicyImage.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.bottomAnchor),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

// MARK: - DishesCollectionViewCell extension

extension DishesCollectionViewCell {
    
    struct ViewModel {
        let imageProvider: ImageProviderProtocol?
        let title: String
        let subtitle: String
        let price: String
        let weight: String
        let isSpicy: Bool
    }
    
    func configure(viewModel: ViewModel) {
        imageView.provider = viewModel.imageProvider
        dishName.text = viewModel.title
        compositionOfTheDish.text = viewModel.subtitle
        spicyImage.isHidden = !viewModel.isSpicy
        
        guard let fontPrice = Constants.fontBold15, let fontWeight = Constants.font13 else { return }
        
        let attributesPrice: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: fontPrice
        ]
        let attributedStringPrice = NSAttributedString(string: viewModel.price + " ₽", attributes: attributesPrice)
        
        let attributesWeight: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: fontWeight
        ]
        let attributedStringWeight = NSAttributedString(
            string: "/ " + viewModel.weight + " г.",
            attributes: attributesWeight
        )
        
        let resultString = NSMutableAttributedString()
        resultString.append(attributedStringPrice)
        resultString.append(NSAttributedString(string: " ", attributes: [:]))
        resultString.append(attributedStringWeight)
        
        infoAboutTheDish.attributedText = resultString
    }
}
