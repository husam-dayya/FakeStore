//
//  RemoteProductsLoader.swift
//  FakeStore
//
//  Created by Husam Dayya on 08/02/2023.
//

import Foundation

public final class RemoteProductsLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Error?) -> Void = { _ in }) {
        client.get(from: url) { error in
            completion(.connectivity)
        }
    }
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (Error?) -> Void)
}
