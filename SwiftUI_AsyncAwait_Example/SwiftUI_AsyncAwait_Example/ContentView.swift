//
//  ContentView.swift
//  SwiftUI_AsyncAwait_Example
//
//  Created by kazunori.aoki on 2021/10/05.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                Text("Data: \(viewModel.data)")
                    
                Button {
                    fetchDataCompletion()
                } label: {
                    Text("Fetch data with Completion")
                }
                
                Button("Fetch data with Concurrency", action: {
                    fetchDataConcurrency()
                })
            }
        }
    }
}


// MARK: Function
private extension ContentView {
    
    // MARK: completion
    func fetchDataCompletion() {
        viewModel.fetchData { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    // MARK: concarrency
    func fetchDataConcurrency() {
        Task {
            do {
               try await viewModel.fetchData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
