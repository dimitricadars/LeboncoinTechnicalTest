//
//  ClassifiedAdUnitTest.swift
//  LeboncoinTechnicalTestUnitTests
//
//  Created by Dimitri CADARS on 05/12/2021.
//

import XCTest
@testable import LeboncoinTechnicalTest

class ClassifiedAdUnitTest: XCTestCase {
    
    var classifiedAdMockService : ClassifiedAdMockService!
    var classifiedAdsViewModel : ClassifiedAdsViewModel!
    var arrayEmptyClassifiedAds:[ClassifiedAdViewModel]!

    //MARK: Set Up
    override func setUp() {
        classifiedAdMockService = ClassifiedAdMockService()
        classifiedAdsViewModel = ClassifiedAdsViewModel(classifiedAdService: classifiedAdMockService)
    }
    
    //MARK: Tear Down
    override func tearDown() {
         super.tearDown()
        classifiedAdMockService = nil
        classifiedAdsViewModel = nil
     }

    //MARK: test with ClassifiedAds
    func testSuccessGetClassifiedAds() {
        
        classifiedAdMockService.getClassifiedAds { resultOfClassifiedAds in
            switch resultOfClassifiedAds {
            case .success(let classifiedAds):
                XCTAssertGreaterThan(classifiedAds.count, 0)
            case .failure(_):
                XCTFail()
                break
            }
        }
    }
    
    //MARK: test with Empty ClassifiedAds
    func testEmptyClassifiedAds() {
        arrayEmptyClassifiedAds = []
        classifiedAdMockService.classifiedAdResult = .success(arrayEmptyClassifiedAds)
        classifiedAdMockService.getClassifiedAds { resultOfClassifiedAds in
            switch resultOfClassifiedAds {
            case .success(let classifiedAds):
                XCTAssertEqual(classifiedAds.count, 0)
            case .failure(_):
                XCTFail()
                break
            }
        }
    }
    
    //MARK: test Failed
    func testFailedGetClassifiedAds() {
        classifiedAdMockService.classifiedAdResult = .failure(NSError(domain: "", code: 1, userInfo: nil))
        classifiedAdMockService.getClassifiedAds { resultOfClassifiedAds in
            switch resultOfClassifiedAds {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
                break
            }
        }
    }

}
