//
//  SushiTests.swift
//  SushiTests
//
//  Created by Анастасия Ступникова on 07.07.2022.
//

import XCTest
@testable import Sushi

final class NetworkServiceTests: XCTestCase {

    private var urlSessionMock: URLSessionMock!
    private var queueMock: DispatchQueueMock!
    private var service: NetworkService!
    
    override func setUpWithError() throws {
        urlSessionMock = URLSessionMock()
        queueMock = DispatchQueueMock()
        service = NetworkService(urlSession: urlSessionMock, queue: queueMock)
    }

    func testMakeImageUrlFailed() throws {
        // act
        let result = service.makeImageURL("https://абв")
        
        // assert
        XCTAssertNil(result)
    }
    
    func testMakeImageUrlSucceeded() throws {
        // act
        let result = service.makeImageURL("/image/123.jpeg")
        
        // assert
        XCTAssertEqual(result?.absoluteString, "https://vkus-sovet.ru/image/123.jpeg")
    }
    
    func testLoadCategoriesFailedNoData() {
        // arrange
        urlSessionMock.completionArgs = (nil, nil, nil)
        var completionResults: [Result<[Sushi.Category], NetworkService.LoadingError>] = []
        
        // act
        service.loadCategories { result in
            completionResults.append(result)
        }
        
        // assert
        XCTAssertEqual(urlSessionMock.makeDataTaskCallsCount, 1)
        XCTAssertEqual(completionResults.count, 1)
        guard
            let result = completionResults.first,
            case .failure(.noData) = result
        else {
            XCTFail("Wrong result")
            return
        }
    }
    
    func testLoadCategoriesFailedWrongData() {
        // arrange
        urlSessionMock.completionArgs = ("test".data(using: .utf8), nil, nil)
        var completionResults: [Result<[Sushi.Category], NetworkService.LoadingError>] = []
        
        // act
        service.loadCategories { result in
            completionResults.append(result)
        }
        
        // assert
        XCTAssertEqual(urlSessionMock.makeDataTaskCallsCount, 1)
        XCTAssertEqual(completionResults.count, 1)
        guard
            let result = completionResults.first,
            case .failure(.wrongData) = result
        else {
            XCTFail("Wrong result")
            return
        }
    }
    
    func testLoadCategoriesSuccess() {
        // arrange
        urlSessionMock.completionArgs = ("""
        {
          "status": true,
          "menuList": [
            {
              "menuID": "21",
              "image": "/upload/iblock/78b/78b05a510583a30c82ddb5d5c94ce73d.jpeg",
              "name": "Сеты",
              "subMenuCount": 7
            }
          ]
        }
        """.data(using: .utf8), nil, nil)
        var completionResults: [Result<[Sushi.Category], NetworkService.LoadingError>] = []
        
        // act
        service.loadCategories { result in
            completionResults.append(result)
        }
        
        // assert
        XCTAssertEqual(urlSessionMock.makeDataTaskCallsCount, 1)
        XCTAssertEqual(completionResults.count, 1)
        guard
            let result = completionResults.first,
            case let .success(categories) = result
        else {
            XCTFail("Wrong result")
            return
        }
        
        XCTAssertEqual(categories.count, 1)
        
        let category = categories.first
        XCTAssertEqual(category?.menuID, "21")
        XCTAssertEqual(category?.image, "/upload/iblock/78b/78b05a510583a30c82ddb5d5c94ce73d.jpeg")
        XCTAssertEqual(category?.name, "Сеты")
        XCTAssertEqual(category?.subMenuCount, 7)
    }
    
    func testLoadDishesFailedNoData() {
        // arrange
        urlSessionMock.completionArgs = (nil, nil, nil)
        var completionResults: [Result<[Sushi.Dish], NetworkService.LoadingError>] = []
        
        // act
        service.loadDishes(menuID: "testMenuID") { result in
            completionResults.append(result)
        }
        
        // assert
        XCTAssertEqual(urlSessionMock.receivedRequest?.httpBody, "menuID=testMenuID".data(using: .utf8))
        XCTAssertEqual(urlSessionMock.makeDataTaskCallsCount, 1)
        XCTAssertEqual(completionResults.count, 1)
        guard
            let result = completionResults.first,
            case .failure(.noData) = result
        else {
            XCTFail("Wrong result")
            return
        }
    }
    
    func testLoadDishesFailedWrongData() {
        // arrange
        urlSessionMock.completionArgs = ("test".data(using: .utf8), nil, nil)
        var completionResults: [Result<[Sushi.Dish], NetworkService.LoadingError>] = []
        
        // act
        service.loadDishes(menuID: "testMenuID") { result in
            completionResults.append(result)
        }
        
        // assert
        XCTAssertEqual(urlSessionMock.receivedRequest?.httpBody, "menuID=testMenuID".data(using: .utf8))
        XCTAssertEqual(urlSessionMock.makeDataTaskCallsCount, 1)
        XCTAssertEqual(completionResults.count, 1)
        guard
            let result = completionResults.first,
            case .failure(.wrongData) = result
        else {
            XCTFail("Wrong result")
            return
        }
    }
    
    func testLoadDishesSuccess() {
        // arrange
        urlSessionMock.completionArgs = ("""
        {
          "status": true,
          "menuList": [
            {
              "content": "testContent",
              "image": "testImage",
              "name": "testName",
              "weight": "testWeight",
              "id": "testID",
              "spicy": null,
              "price": "testPrice"
            }
          ]
        }
        """.data(using: .utf8), nil, nil)
        var completionResults: [Result<[Sushi.Dish], NetworkService.LoadingError>] = []
        
        // act
        service.loadDishes(menuID: "testMenuID") { result in
            completionResults.append(result)
        }
        
        // assert
        XCTAssertEqual(urlSessionMock.receivedRequest?.httpBody, "menuID=testMenuID".data(using: .utf8))
        XCTAssertEqual(urlSessionMock.makeDataTaskCallsCount, 1)
        XCTAssertEqual(completionResults.count, 1)
        guard
            let result = completionResults.first,
            case let .success(dishes) = result
        else {
            XCTFail("Wrong result")
            return
        }
        
        XCTAssertEqual(dishes.count, 1)
        
        let dish = dishes.first
        XCTAssertEqual(dish?.content, "testContent")
        XCTAssertEqual(dish?.image, "testImage")
        XCTAssertEqual(dish?.name, "testName")
        XCTAssertEqual(dish?.id, "testID")
        XCTAssertEqual(dish?.spicy, nil)
        XCTAssertEqual(dish?.weight, "testWeight")
        XCTAssertEqual(dish?.price, "testPrice")
    }
}
