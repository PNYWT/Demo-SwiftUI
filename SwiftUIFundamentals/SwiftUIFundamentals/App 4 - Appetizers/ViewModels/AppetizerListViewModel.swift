//
//  AppetizerListViewModel.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import Foundation
import Combine

@MainActor final class AppetizerListViewModel: ObservableObject {
    
    @Published var appetizers: [AppetizerModel] = []
    @Published var alertItemNetwork: AlertItemAppertizer?
    @Published var isLoading: Bool = false
    
    @Published var isShowingDetail = false
    @Published var selectedAppetizer: AppetizerModel?
    
    
    func getAppetizers() async {
        isLoading = true
        
        Task {
            do {
                appetizers = try await NetworkManager.shared.getAppetizers(endPoint: .appetizers)
                isLoading = false
            } catch {
                isLoading = false
                guard let netError = error as? NetworkError else {
                    alertItemNetwork = AlertContextAppertizer.invalidResponse
                    return
                }
                switch netError {
                case .invalidURL:
                    alertItemNetwork = AlertContextAppertizer.invalidURL
                case .invalidResponse:
                    alertItemNetwork = AlertContextAppertizer.invalidResponse
                case .invalidData:
                    alertItemNetwork = AlertContextAppertizer.invalidData
                case .unableToComplete:
                    alertItemNetwork = AlertContextAppertizer.unableToComplete
                }
            }
        }
    }
    
    
//    private var getAppetizersCancellable: AnyCancellable?
    
    /*
     func getAppetizers() {
         isLoading = true
         getAppetizersCancellable?.cancel()
         getAppetizersCancellable = NetworkManager.shared.getAppetizers(endPoint: .appetizers)
             .delay(for: .seconds(1), scheduler: DispatchQueue.main)
         //            .receive(on: DispatchQueue.main)
             .sink(receiveCompletion: { completion in
                 self.isLoading = false
                 switch completion {
                 case .failure(let error):
                     switch error {
                     case .invalidURL:
                         self.alertItemNetwork = AlertContextAppertizer.invalidURL
                     case .invalidResponse:
                         self.alertItemNetwork = AlertContextAppertizer.invalidResponse
                     case .invalidData:
                         self.alertItemNetwork = AlertContextAppertizer.invalidData
                     case .unableToComplete:
                         self.alertItemNetwork = AlertContextAppertizer.unableToComplete
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
     */
}
