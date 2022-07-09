//
//  ImageProvider.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 08.07.2022.
//

import UIKit

typealias ImageCompletion = (UIImage?) -> Void

protocol ImageProviderProtocol {
    func load(completion: @escaping ImageCompletion)
}

final class ImageProviderUrl: ImageProviderProtocol {
    
    // MARK: - Private Properties
    
    private let url: URL
    private let mainQueue: DispatchQueueProtocol
    private let globalQueue: DispatchQueueProtocol
    
    private var completionBlock: ImageCompletion?
    
    // MARK: - Initializers
    
    init(url: URL, mainQueue: DispatchQueueProtocol, globalQueue: DispatchQueueProtocol) {
        self.url = url
        self.mainQueue = mainQueue
        self.globalQueue = globalQueue
    }
    
    convenience init(url: URL) {
        self.init(url: url, mainQueue: DispatchQueue.main, globalQueue: DispatchQueue.global())
    }
    
    // MARK: - Public Methods

    func load(completion: @escaping ImageCompletion) {
        completionBlock = completion
        globalQueue.async { self.startLoading() }
    }
    
    // MARK: - Private Methods

    private func startLoading() {
        let data = try? Data(contentsOf: url)
        guard let imageData = data else {
            callCompletion(with: nil)
            return
        }

        let image = UIImage(data: imageData)
        callCompletion(with: image)
    }

    private func callCompletion(with image: UIImage?) {
        mainQueue.async { self.completionBlock?(image) }
    }
}
