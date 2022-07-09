//
//  DispatchQueueMock.swift
//  SushiTests
//
//  Created by Анастасия Ступникова on 09.07.2022.
//

@testable import Sushi

final class DispatchQueueMock: DispatchQueueProtocol {
    var asyncCallsCount = 0
    
    func async(execute work: @escaping () -> Void) {
        asyncCallsCount += 1
        work()
    }
}
