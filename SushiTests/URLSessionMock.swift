//
//  URLSessionMock.swift
//  SushiTests
//
//  Created by Анастасия Ступникова on 09.07.2022.
//

import Foundation
@testable import Sushi

final class URLSessionMock: URLSessionProtocol {
    var makeDataTaskReturns = URLSessionDataTaskMock()
    var completionArgs: (Data?, URLResponse?, Error?)?
    
    var receivedRequest: URLRequest?
    var makeDataTaskCallsCount = 0
    
    func makeDataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        receivedRequest = request
        makeDataTaskCallsCount += 1
        completionArgs.map { completionHandler($0.0, $0.1, $0.2) }
        return makeDataTaskReturns
    }
}
