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
        printTitle(models: [
            Contacts(),
            Summary(),
            Skills(),
            Education(),
            Experience(),
            Additional()
            ])
    }
    
    func printTitle(models: [Codable]) {
        for model in models {
            if let model = model as? Contacts {
                sleep(0)
                print(model.title)
            } else if let model = model as? Summary {
                sleep(1)
                print(model.title)
            } else if let model = model as? Skills {
                sleep(1)
                print(model.title)
            } else if let model = model as? Education {
                sleep(1)
                print(model.title)
            } else if let model = model as? Experience {
                sleep(1)
                print(model.iosDeveloping)
            } else if let model = model as? Additional {
                sleep(1)
                print(model.title)
            }
        }
    }

}
