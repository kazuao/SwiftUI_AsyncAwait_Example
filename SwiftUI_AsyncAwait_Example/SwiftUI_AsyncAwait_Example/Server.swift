//
//  Server.swift
//  SwiftUI_AsyncAwait_Example
//
//  Created by kazunori.aoki on 2021/10/05.
//

import Foundation

struct Server {
    
    static func get(completion: @escaping (Result<String, Error>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            Int.random(in: 1...2) == 1
            ? completion(.failure(CustomError.notFound))
            : completion(.success("Alex"))
        }
    }
}

enum CustomError: Error {
    case notFound
}
