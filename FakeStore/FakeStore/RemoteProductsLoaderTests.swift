//
//  RemoteProductsLoaderTests.swift
//  FakeStoreTests
//
//  Created by Husam Dayya on 01/02/2023.
//

import XCTest

class RemoteProductsLoader {
    
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    func load() {
        client.get(from: URL(string: "https://a-url.com")!)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
    
    var requestedURL: URL?
    
    func get(from url: URL) {
        requestedURL = url
    }
}

final class RemoteProductsLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        _ = RemoteProductsLoader(client: client)
        
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestsDataFromURL() {
        let client = HTTPClientSpy()
        let sut = RemoteProductsLoader(client: client)
        
        sut.load( )
        
        XCTAssertNotNil(client.requestedURL)
    }

}
