//
//  NetworkManager.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 10/3/2568 BE.
//

import Foundation
import Combine
import UIKit
import SwiftUICore

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
    
    func getAppetizers(endPoint: EndPoint) async throws -> [AppetizerModel] {
        guard let url = URL(string: "\(baseURL)\(endPoint.rawValue)") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        print("getAppetizers response -> \(response)")
        
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(AppetizerResponse.self, from: data)
            return decodedResponse.request
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    
    /*
     func getAppetizers(endPoint: EndPoint) -> AnyPublisher<[AppetizerModel], NetworkError> {
         
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
     */
    
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
                guard let networkError = error as? NetworkError else {
                    return .unableToComplete
                }
                return networkError
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func loadCachedImage(url: String) -> UIImage? {
        guard let cachedImage = cache.object(forKey: NSString(string: url)) else {
            return nil
        }
        return cachedImage
    }
    
    @MainActor func cacheImage(_ image: Image, for url: String) {
        guard let haveUIImage = image.asUIImage() else {
            return
        }
        self.cache.setObject(haveUIImage, forKey: NSString(string: url))
    }
}
