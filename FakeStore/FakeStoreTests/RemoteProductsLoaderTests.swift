//
//  RemoteProductsLoaderTests.swift
//  FakeStoreTests
//
//  Created by Husam Dayya on 01/02/2023.
//

import XCTest
import FakeStore

final class RemoteProductsLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataTwiceFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.load()
        sut.load()
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        var capturedErrors = [RemoteProductsLoader.Error?]()
        sut.load { capturedErrors.append($0) }
        
        let clientError = NSError(domain: "any", code: 0)
        client.complete(with: clientError)
        
        XCTAssertEqual(capturedErrors, [.connectivity])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteProductsLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteProductsLoader(url: url, client: client)
        
        return (sut, client)
    }
    
    private class HTTPClientSpy: HTTPClient {
        var messages = [(url: URL, complete: (Error?) -> Void)]()
        
        var requestedURLs: [URL] {
            messages.map(\.url)
        }
        
        func get(from url: URL, completion: @escaping (Error?) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error?, at index: Int = 0) {
            messages[index].complete(error)
        }
    }

}
