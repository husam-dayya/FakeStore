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
        case invalidData
    }
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (Error?) -> Void) {
        client.get(from: url) { result in
            switch result {
            case .success:
                completion(.invalidData)
            case .failure:
                completion(.connectivity)
            }
        }
    }
}

public protocol HTTPClient {
    typealias Result = Swift.Result<HTTPURLResponse, Error>
    
    func get(from url: URL, completion: @escaping (Result) -> Void)
}
