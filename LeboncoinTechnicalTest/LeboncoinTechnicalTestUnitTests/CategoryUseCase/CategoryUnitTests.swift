//
//  CategoryUnitTests.swift
//  LeboncoinTechnicalTestUnitTests
//
//  Created by Dimitri CADARS on 05/12/2021.
//

import XCTest
@testable import LeboncoinTechnicalTest

class CategoryUnitTests: XCTestCase {
    
    var categoryMockService : CategoryMockService!
    var categoriesViewModel : CategoriesViewModel!
    var arrayEmptyCategories:[CategoryViewModel]!

    //MARK: Set Up
    override func setUp() {
        categoryMockService = CategoryMockService()
        categoriesViewModel = CategoriesViewModel(categoryService: categoryMockService)
    }
    
    //MARK: Tear Down
    override func tearDown() {
         super.tearDown()
        categoryMockService = nil
        categoriesViewModel = nil
     }

    //MARK: test with Categories
    func testSuccessGetCategories() {
        
        categoryMockService.getCategories { resultOfCategories in
            switch resultOfCategories {
            case .success(let categories):
                XCTAssertGreaterThan(categories.count, 0)
            case .failure(_):
                XCTFail()
                break
            }
        }
    }
    
    //MARK: test with Empty Categories
    func testEmptyCategories() {
        arrayEmptyCategories = []
        categoryMockService.categoryResult = .success(arrayEmptyCategories)
        categoryMockService.getCategories { resultOfCategories in
            switch resultOfCategories {
            case .success(let categories):
                XCTAssertEqual(categories.count, 0)
            case .failure(_):
                XCTFail()
                break
            }
        }
    }
    
    //MARK: test Failed
    func testFailedGetCategories() {
        categoryMockService.categoryResult = .failure(NSError(domain: "", code: 1, userInfo: nil))
        categoryMockService.getCategories { resultOfCategories in
            switch resultOfCategories {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
                break
            }
        }
    }

}
