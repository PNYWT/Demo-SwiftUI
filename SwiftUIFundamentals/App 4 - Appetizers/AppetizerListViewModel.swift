//
//  AppetizerListViewModel.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import Foundation
import Combine

final class AppetizerListViewModel: ObservableObject {
    
    @Published var appetizers: [Appetizer] = []
    @Published var alertItemNetwork: AlertItemNetwork?
    @Published var isLoading: Bool = false
    
    private var getAppetizersCancellable: AnyCancellable?
    
    func getAppetizers() {
        isLoading = true
        getAppetizersCancellable?.cancel()
        getAppetizersCancellable = NetworkManager.shared.getAppetizers(endPoint: .appetizers)
            .delay(for: .seconds(5), scheduler: DispatchQueue.main)
        //            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self.alertItemNetwork = AlertContextNetwork.invalidURL
                    case .invalidResponse:
                        self.alertItemNetwork = AlertContextNetwork.invalidResponse
                    case .invalidData:
                        self.alertItemNetwork = AlertContextNetwork.invalidData
                    case .unableToComplete:
                        self.alertItemNetwork = AlertContextNetwork.unableToComplete
                    }
                    print("error -> \(error.localizedDescription)")
                case .finished:
                    print("✅ API Call Finished")
                }
            }, receiveValue: { appetizers in
                print("appetizers -> \(appetizers)")
                self.appetizers = appetizers
            })
    }
}
