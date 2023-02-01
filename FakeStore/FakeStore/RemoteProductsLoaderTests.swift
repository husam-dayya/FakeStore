//
//  RemoteProductsLoaderTests.swift
//  FakeStoreTests
//
//  Created by Husam Dayya on 01/02/2023.
//

import XCTest

class RemoteProductsLoader {
    func load() {
        HTTPClient.shared.get(from: URL(string: "https://a-url.com")!)
    }
}

class HTTPClient {
    static var shared = HTTPClient()
            
    func get(from url: URL) {}
}

class HTTPClientSpy: HTTPClient {
    
    var requestedURL: URL?
    
    override func get(from url: URL) {
        requestedURL = url
    }
}

final class RemoteProductsLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        _ = RemoteProductsLoader()
        
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestsDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        let sut = RemoteProductsLoader()
        
        sut.load( )
        
        XCTAssertNotNil(client.requestedURL)
    }

}
