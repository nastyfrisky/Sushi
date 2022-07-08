//
//  DishesCollectionViewCell.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 08.07.2022.
//

import UIKit

final class DishesCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let dishName = UILabel()
    private let compositionOfTheDish = UILabel()
    private let infoAboutTheDish = UILabel()
    private let spicyImage = UIImageView()
    private let view = UIView()
    private let button = UIButton()
    
    private let fontBold15 = UIFont(name: "HelveticaNeue-Bold", size: 15.0)
    private let font13 = UIFont(name: "HelveticaNeue", size: 13.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        dishName.font = fontBold15
        dishName.textColor = .white
        
        compositionOfTheDish.font = font13
        compositionOfTheDish.textColor = .lightGray
        compositionOfTheDish.numberOfLines = 0
        compositionOfTheDish.textAlignment = .center
        compositionOfTheDish.lineBreakStrategy = .hangulWordPriority
        
        button.backgroundColor = Constants.violetColor
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 15.0)
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
            compositionOfTheDish.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            compositionOfTheDish.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
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

extension DishesCollectionViewCell {
    
    struct ViewModel {
        let image: UIImage?
        let title: String
        let subtitle: String
        let price: String
        let weight: String
        let spicyImage: UIImage?
    }
    
    func configure(viewModel: ViewModel) {
        imageView.image = viewModel.image
        dishName.text = viewModel.title
        compositionOfTheDish.text = viewModel.subtitle
        spicyImage.image = viewModel.spicyImage
        
        guard let fontPrice = fontBold15, let fontWeight = font13 else { return }
        
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
