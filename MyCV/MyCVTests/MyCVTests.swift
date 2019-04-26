//
//  MyCVTests.swift
//  MyCVTests
//
//  Created by Dima Dobrovolskyy on 4/24/19.
//  Copyright © 2019 Dima Dobrovolskyy. All rights reserved.
//

import XCTest
@testable import MyCV

class MyCVTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testModels() {
        testJSONParser(for: Contacts())
        testJSONParser(for: Summary())
        testJSONParser(for: Skills())
        testJSONParser(for: Education())
        testJSONParser(for: Experience())
        testJSONParser(for: Additional())
    }
    
    func testJSONParser<Model>(for model: Model) where Model: JSONable{
        model.parseJSON { result in
            switch result {
                
            case .success(let data):
                print(data)
                
            case .failure(let err):
                print(err)
                
            }
        }
    }

}
