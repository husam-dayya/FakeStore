//
//  ProductsLoader.swift
//  FakeStore
//
//  Created by Husam Dayya on 01/02/2023.
//

import Foundation

protocol ProductsLoader {
    typealias Result = Swift.Result<[Product], Error>
    
    func load(completion: @escaping (Result) -> Void)
}
