//
//  LeboncoinTechnicalTestUITests.swift
//  LeboncoinTechnicalTestUITests
//
//  Created by Dimitri CADARS on 05/12/2021.
//

import XCTest

class LeboncoinTechnicalTestUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testClassifiedAdList() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print(app.debugDescription)
        let tableView = app.tables["classifiedAdsTableView"]
        XCTAssertTrue(tableView.exists, "classifiedAdsTableView doesn't exist")
        XCTAssertTrue(app.buttons["filterBarButton"].exists, "filterBarButton doesn't exist")

        let cells = tableView.cells
        XCTAssertGreaterThanOrEqual(cells.count, 0)
        
        if cells.count > 0 {
            let promise = expectation(description: "classifiedAdsTableViewCells expectation")
            
            let classifiedAdCell = cells.element(boundBy: 0)
            XCTAssertTrue(classifiedAdCell.exists, "classifiedAdsTableViewCell doesn't exist")
            promise.fulfill()
            waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(true, "failure")
            XCTAssertTrue(app.images["classifiedAdImage"].exists, "classifiedAdImage doesn't exist")
            XCTAssertTrue(app.staticTexts["titleLabel"].exists, "titleLabel doesn't exist")
            XCTAssertTrue(app.staticTexts["categoryLabel"].exists, "categoryLabel doesn't exist")
            XCTAssertTrue(app.staticTexts["priceLabel"].exists, "priceLabel doesn't exist")
            XCTAssertTrue(app.staticTexts["urgentLabel"].exists, "urgentLabel doesn't exist")
            
        } else {
            XCTAssert(false, "classifiedAdsTableViewCells doesn't exist")
        }
        
        app.swipeUp()
        app.swipeDown()
    }
    
    func testClassifiedAdDetail() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        print(app.debugDescription)
        let tableView = app.tables["classifiedAdsTableView"]
        XCTAssertTrue(tableView.exists, "classifiedAdsTableView doesn't exist")
        XCTAssertTrue(app.buttons["filterBarButton"].exists, "filterBarButton doesn't exist")
        
        let cells = tableView.cells
        XCTAssertGreaterThanOrEqual(cells.count, 0)
        
        if cells.count > 0 {
            let promise = expectation(description: "classifiedAdsTableViewCells expectation")
            
            let classifiedAdCell = cells.element(boundBy: 0)
            XCTAssertTrue(classifiedAdCell.exists, "classifiedAdsTableViewCell doesn't exist")
            promise.fulfill()
            waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(true, "failure")
            
            classifiedAdCell.tap()
            XCTAssertTrue(app.buttons["closeDetailButton"].exists, "closeDetailButton doesn't exist")
            XCTAssertTrue(app.images["classifiedAdDetailImage"].exists, "classifiedAdDetailImage doesn't exist")
            XCTAssertTrue(app.staticTexts["titleDetailLabel"].exists, "titleDetailLabel doesn't exist")
            XCTAssertTrue(app.staticTexts["priceDetailLabel"].exists, "priceDetailLabel doesn't exist")
            XCTAssertTrue(app.staticTexts["dateDetailLabel"].exists, "dateDetailLabel doesn't exist")
            XCTAssertTrue(app.staticTexts["descriptionTitleDetailLabel"].exists, "descriptionTitleDetailLabel doesn't exist")
            XCTAssertTrue(app.staticTexts["descriptionDetailLabel"].exists, "descriptionDetailLabel doesn't exist")
            
            let closeDetailButton = app.buttons["closeDetailButton"]
            closeDetailButton.tap()
        } else {
            XCTAssert(false, "classifiedAdsTableViewCells doesn't exist")
        }
    }

    func testCategoryList() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["filterBarButton"].tap()
        print(app.debugDescription)
        XCTAssertTrue(app.staticTexts["categoryTitle"].exists, "categoryTitle doesn't exist")
        let tableView = app.tables["categoriesTableView"]
        XCTAssertTrue(tableView.exists, "categoriesTableView doesn't exist")
        XCTAssertTrue(app.buttons["filterCloseButton"].exists, "filterCloseButton doesn't exist")
        
        let cells = tableView.cells
        XCTAssertGreaterThanOrEqual(cells.count, 0)
        
        if cells.count > 0 {
            let promise = expectation(description: "TableViewCells expectation")
            
            let category = cells.element(boundBy: 0)
            XCTAssertTrue(category.exists, "categoriesTableViewCell doesn't exist")
            promise.fulfill()
            waitForExpectations(timeout: 10, handler: nil)
            XCTAssertTrue(true, "failure")
            category.tap()
         
        } else {
            XCTAssert(false, "categoriesTableViewCells doesn't exist")
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
