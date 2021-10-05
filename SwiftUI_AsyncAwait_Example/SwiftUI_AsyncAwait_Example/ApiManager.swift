//
//  APIManager.swift
//  SwiftUI_AsyncAwait_Example
//
//  Created by kazunori.aoki on 2021/10/05.
//

import Foundation

struct ApiManager {
    
    // MARK: Completion
    static func getData(completion: @escaping (Result<String, Error>) -> ()) {
        Server.get(completion: completion)
    }
    
    // MARK: Concurrency
    static func getData() async throws -> String {
        try await withCheckedThrowingContinuation({ continuation in
            Server.get { result in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
}
