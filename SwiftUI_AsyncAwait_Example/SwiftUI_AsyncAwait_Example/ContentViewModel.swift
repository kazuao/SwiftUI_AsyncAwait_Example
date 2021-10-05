//
//  ContentViewModel.swift
//  SwiftUI_AsyncAwait_Example
//
//  Created by kazunori.aoki on 2021/10/05.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var data: String = ""
    
    // MARK: Completion
    func fetchData(completion: @escaping (Error?) -> ()) {
        ApiManager.getData { result in
            switch result {
                
            case .success(let data):
                self.data = data
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    // MARK: Concarrency
    // MainThreadを使用する
    @MainActor // @Publishedに Async/Awaitで同期するときは、MainThreadでなくてはならない
    func fetchData() async throws {
        self.data = try await ApiManager.getData()
    }
}
