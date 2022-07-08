//
//  HeaderView.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 07.07.2022.
//

import UIKit

final class HeaderView: UIView {
    private let imageView = UIImageView()
    private let button = UIButton()
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        imageView.image = UIImage(named: "logo")
        
        addSubview(imageView)
        addSubview(button)
    }
    
    private func setupSubviews() {
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        button.imageView?.tintColor = UIColor.white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
    }
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            button.widthAnchor.constraint(equalToConstant: 30),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
