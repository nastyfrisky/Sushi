//
//  Response.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 08.07.2022.
//

struct MenuResponse<T: Decodable>: Decodable {
    let status: Bool
    let menuList: [T]
}
