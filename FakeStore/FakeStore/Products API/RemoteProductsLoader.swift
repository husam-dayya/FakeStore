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
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load() {
        client.get(from: url)
    }
}

public protocol HTTPClient {
    func get(from url: URL)
}
