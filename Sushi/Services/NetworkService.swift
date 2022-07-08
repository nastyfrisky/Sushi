//
//  NetworkService.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 08.07.2022.
//

import Foundation

final class NetworkService {
    enum LoadingError: Error {
        case wrongData
        case noData
    }
    
    // MARK: - Private Properties
    
    private let urlSession = URLSession.shared
    private let host = "vkus-sovet.ru"
    
    // MARK: - Public Methods
    
    func loadCategories(completion: @escaping (Result<[Category], LoadingError>) -> Void) {
        guard let url = apiUrl(for: "getMenu") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        executeTask(request: request, completion: completion)
    }
    
    func loadDishes(
        menuID: String,
        completion: @escaping (Result<[Dish], LoadingError>) -> Void
    ) {
        guard let url = apiUrl(for: "getSubMenu") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters: [String: String] = [
            "menuID": menuID
        ]
        
        request.httpBody = parameters.percentEncoded()
        
        executeTask(request: request, completion: completion)
    }
    
    func makeImageURL(_ shortURL: String) -> URL? {
        imageUrl(for: shortURL)
    }
    
    // MARK: - Private Methods
    
    private func executeTask<T: Decodable>(
        request: URLRequest,
        completion: @escaping (Result<[T], LoadingError>) -> Void
    ) {
        urlSession.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data else {
                self?.callCompletion(completion, .failure(.noData))
                return
            }

            print(String(decoding: data, as: UTF8.self))
            
            guard let decodedData = try? JSONDecoder().decode(MenuResponse<T>.self, from: data) else {
                self?.callCompletion(completion, .failure(.wrongData))
                return
            }
            
            
            self?.callCompletion(completion, .success(decodedData.menuList))
        }.resume()
    }
    
    private func callCompletion<T>(_ completion: @escaping (T) -> Void, _ parameter: T) {
        DispatchQueue.main.async { completion(parameter) }
    }
    
    private func apiUrl(for method: String) -> URL? {
        URL(string: "https://\(host)/api/\(method).php")
    }
    
    private func imageUrl(for image: String) -> URL? {
        URL(string: "https://\(host)\(image)")
    }
}

// MARK: - Dictionary extension

private extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return "\(escapedKey)=\(escapedValue)"
        }.joined(separator: "&").data(using: .utf8)
    }
}
