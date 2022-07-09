//
//  DispatchQueueProtocol.swift
//  Sushi
//
//  Created by Анастасия Ступникова on 09.07.2022.
//

import Foundation

protocol DispatchQueueProtocol {
    func async(execute work: @escaping () -> Void)
}

extension DispatchQueue: DispatchQueueProtocol {
    func async(execute work: @escaping () -> Void) {
        self.async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
