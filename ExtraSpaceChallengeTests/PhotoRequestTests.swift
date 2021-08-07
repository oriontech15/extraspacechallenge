//
//  ExtraSpaceChallengeTests.swift
//  ExtraSpaceChallengeTests
//
//  Created by orion on 8/6/21.
//

import XCTest
@testable import ExtraSpaceChallenge

class PhotoRequestTests: XCTestCase {

    var photosViewModel: PhotosViewModel?
    
    override func setUpWithError() throws {
        photosViewModel = PhotosViewModel()
    }

    override func tearDownWithError() throws {
        photosViewModel = nil
    }
    
    func testPhotosPaginationCurrentPage() {
        
        let expectation = self.expectation(description: "FetchingPhotos")
        photosViewModel?.getNextPageOfPhotoData()
        
        photosViewModel?.updateForBinded = {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(photosViewModel?.currentPage, 1)
    }
    
    func testPhotosPaginationTotalPages() {
        
        let expectation = self.expectation(description: "FetchingPhotos")
        photosViewModel?.getNextPageOfPhotoData()
        
        photosViewModel?.updateForBinded = {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(photosViewModel?.nextPage, 2)
    }
    
    func testNumberOfPhotosAfterNewPageWithPageSizeTen() {
        photosViewModel?.pageSize = 10
        
        let expectation = self.expectation(description: "FetchingPhotos")
        photosViewModel?.getNextPageOfPhotoData()
        
        photosViewModel?.updateForBinded = {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(photosViewModel?.photoData?.count, 10)
    }
    
    func testNumberOfPhotosAfterNewPageWithPageSizeTwenty() {
        photosViewModel?.pageSize = 20
        let expectation = self.expectation(description: "FetchingPhotos")
        photosViewModel?.getNextPageOfPhotoData()
        
        photosViewModel?.updateForBinded = {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(photosViewModel?.photoData?.count, 20)
    }
    
    func testGenericAPICall() {
        let apiService = APIService()
        
        let url = URL(string: "https://www.google.com")
        let urlRequest = URLRequest(url: url!)
        let expectation = self.expectation(description: "GenericRequest")

        var testData: Data?
        
        apiService.fetchDataFor(urlRequest: urlRequest) { data in
            testData = data
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(testData)
    }
}
