//
//  ImageTests.swift
//  ExtraSpaceChallengeTests
//
//  Created by orion on 8/7/21.
//

import XCTest

class ImageTests: XCTestCase {

    var image: UIImage?
    override func setUpWithError() throws {
        let size = CGSize(width: 50, height: 50)
        let expectation = expectation(description: "ImageCreation")
        
        image = UIGraphicsImageRenderer(size: size).image { rendererContext in
            UIColor.red.setFill()
                    rendererContext.fill(CGRect(origin: .zero, size: size))
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        image = nil
    }

    func testImageToCache() {
        image?.cache(with: "www.google.com")
        let image = UIImage.getPhotoFromCache(with: "www.google.com")
        
        XCTAssertNotNil(image)
    }
    
    func testImageFromCacheWithURL() {
        image?.cache(with: "www.google.com")
        
        var retrievedImage: UIImage?
        let expectation = expectation(description: "ImageFromCache")

        UIImage.getPhotoForURL(url: URL(string: "www.google.com")!) { image in
            retrievedImage = image
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        XCTAssertNotNil(retrievedImage)
    }
}
