//
//  RemoteProductsLoaderTests.swift
//  FakeStoreTests
//
//  Created by Husam Dayya on 01/02/2023.
//

import XCTest

class RemoteProductsLoader {
    
}

class HTTPClient {
    var requestedURL: URL?
}

final class RemoteProductsLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        _ = RemoteProductsLoader()
        
        
        XCTAssertNil(client.requestedURL)
    }

}
