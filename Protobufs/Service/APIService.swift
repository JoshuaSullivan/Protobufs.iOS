//
//  APIService.swift
//  Protobufs
//
//  Created by Joshua Sullivan on 4/3/17.
//  Copyright © 2017 The Nerdery. All rights reserved.
//

import Foundation

class APIService {
    
    // MARK: - Singleton
    
    private static let _shared: APIService = {
        let basePath = "http://localhost:8080"
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
    
    func send(message: String, completion: @escaping (Result<String>) -> Void) {
        var proto = SimpleMessage()
        proto.content = message
        guard let protoData = try? proto.serializedData() else {
            print("Failed to create protobuf for sending.")
            completion(.failure(nil))
            return
        }
        let requestURL = baseURL.appendingPathComponent("/proto")
        var request = URLRequest(url: requestURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.httpBody = protoData
        URLSession.shared.dataTask(with: request) {
            (optData, optResponse, optError) in
            DispatchQueue.main.async {
                if let error = optError {
                    print("Request failed: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                guard
                    let data = optData,
                    let sMsg = try? SimpleMessage(serializedData: data)
                else {
                    print("Failed to deserialize Protocol Buffer.")
                    completion(.failure(nil))
                    return
                }
                completion(.success(sMsg.content))
            }
        }.resume()
    }
    
    // MARK: - Receiving
}

enum Result<T> {
    case success(T)
    case failure(Error?)
}
