//
//  URLSessionDataTaskMock.swift
//  SushiTests
//
//  Created by Анастасия Ступникова on 09.07.2022.
//

@testable import Sushi

final class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    var resumeCallsCount: Int = 0
    
    func resume() {
        resumeCallsCount += 1
    }
}
