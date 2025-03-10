//
//  NetworkManager.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import Foundation
import Combine
import UIKit

enum EndPoint: String {
    case appetizers = "appetizers"
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    private let baseURL = "https://seanallen-course-backend.herokuapp.com/swiftui-fundamentals/"
    
    private init() {
        
    }
    
    func getAppetizers(endPoint: EndPoint) -> AnyPublisher<[Appetizer], NetworkError> {
        
        guard let url = URL(string: "\(baseURL)\(endPoint.rawValue)") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { result -> Data in
                print("result.response -> \(result.response)")
                guard let response = result.response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    throw NetworkError.invalidResponse
                }
                return result.data
            }
            .decode(type: AppetizerResponse.self, decoder: JSONDecoder())
            .map { $0.request }
            .mapError { error -> NetworkError in
                if let _ = error as? DecodingError {
                    return .invalidData
                }
                return .unableToComplete
            }
            .eraseToAnyPublisher()
    }
    
    func downloadImage(urlString: String) -> AnyPublisher<UIImage?, NetworkError> {
        let cacheKey = NSString(string: urlString)
        
        // have cache image in cache
        if let cachedImage = cache.object(forKey: cacheKey) {
            return Just(cachedImage)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        // no cacheImage in cache
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { result -> UIImage in
                guard let response = result.response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    throw NetworkError.invalidResponse
                }
                
                guard let image = UIImage(data: result.data) else {
                    throw NetworkError.invalidData
                }
                self.cache.setObject(image, forKey: cacheKey)
                
                return image
            }
            .mapError { error -> NetworkError in
                if let networkError = error as? NetworkError {
                    return networkError
                }
                return .unableToComplete
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}



