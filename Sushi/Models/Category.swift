//
//  Category.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 08.07.2022.
//

struct Category: Decodable {
    let menuID: String
    let image: String
    let name: String
    let subMenuCount: Int
}
