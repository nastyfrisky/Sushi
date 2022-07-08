//
//  ImageView.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 08.07.2022.
//

import UIKit

final class ImageView: UIImageView {
    var provider: ImageProviderProtocol? {
        didSet {
            loadImage()
        }
    }

    private func loadImage() {
        provider?.load { [weak self] image in
            self?.image = image
        }
    }
}
