//
//  RemoteProductsLoaderTests.swift
//  FakeStoreTests
//
//  Created by Husam Dayya on 01/02/2023.
//

import XCTest

class RemoteProductsLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load() {
        client.get(from: url)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

final class RemoteProductsLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let client = HTTPClientSpy()
        _ = RemoteProductsLoader(url: url, client: client)
        
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteProductsLoader(url: url, client: client)
        
        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }
    
    // MARK: - Helpers
    
    private class HTTPClientSpy: HTTPClient {
        
        var requestedURL: URL?
        
        func get(from url: URL) {
            requestedURL = url
        }
    }

}
