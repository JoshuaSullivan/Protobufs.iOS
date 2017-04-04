//
//  APIService.swift
//  Protobufs
//
//  Created by Joshua Sullivan on 4/3/17.
//  Copyright © 2017 The Nerdery. All rights reserved.
//

import Foundation

fileprivate let apiKey = "0e63e5f89934aad2fa5e1d76e5d7a2bd";

class APIService {
    
    // MARK: Child Types and Constants
    
    
    
    // MARK: - Singleton
    
    private static let _shared: APIService = {
        let basePath = "http://www.google.com/"
        guard let url = URL(string: basePath) else {
            fatalError("Could not create the base URL for the APIService.")
        }
        return APIService(baseURL: url)
    }()
    
    /// The shared singleton instance of APIService.
    class var shared: APIService {
        return _shared
    }
    
    // MARK: - Properties
    
    fileprivate let baseURL: URL
    
    // MARK: - Lifecycle
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    // MARK: - Sending
    
    // MARK: - Receiving
}
