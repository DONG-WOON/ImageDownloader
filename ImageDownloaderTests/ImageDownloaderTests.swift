//
//  ImageDownloaderTests.swift
//  ImageDownloaderTests
//
//  Created by 서동운 on 2/22/23.
//

import XCTest
@testable import ImageDownloader

final class ImageDownloaderTests: XCTestCase {
    
    let url = "https://picsum.photos/150/150"
    
    var imageDownloader: ImageDownloader!
    var session: URLSession!
    
    func test_ImageDownloader_downloadImage() {

        let expectation = XCTestExpectation(description: "Download image")
        
        imageDownloader.downloadImage(stringURL: url) { result in
            switch result {
            case .success(let image):
                XCTAssertNotNil(image)
                expectation.fulfill()
            case .failure(let error):
                print(error)
                XCTFail("Expected Test Success, but Load Image failure")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        session = URLSession.shared
        imageDownloader = ImageDownloader(session: session)
    }
    
    override func tearDownWithError() throws {
        session = nil
        imageDownloader = nil
        try super.tearDownWithError()
    }
}
