//
//  Dish.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 08.07.2022.
//

struct Dish: Decodable {
    let id: String
    let image: String
    let name: String
    let content: String
    let price: String
    let weight: String?
    let spicy: String?
}
