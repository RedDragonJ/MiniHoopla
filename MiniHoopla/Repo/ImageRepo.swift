//
//  ImageRepo.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

import UIKit

class ImageRepo: ImageRepoInterface {
    
    private var urlSession: URLSession
    private let cache: URLCache
    
    init(urlSession: URLSession = URLSession(configuration: .ephemeral), cache: URLCache = URLCache.shared) {
        self.urlSession = urlSession
        self.cache = cache
    }
    
    func getImage(url: URL) async throws -> UIImage? {
        
        let request = URLRequest(url: url)
        
        if let cachedData = cache.cachedResponse(for: request)?.data, let image = UIImage(data: cachedData) {
            return image
        } else {
            return try await fetchImage(url: url)
        }
    }
    
    func fetchImage(url: URL) async throws -> UIImage? {
        let (data, response) = try await urlSession.data(from: url)
        guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let image = UIImage(data: data)
        
        saveToCache(url: url, response: response, data: data)
                
        return image
    }
    
    func saveToCache(url: URL, response: URLResponse, data: Data) {
        let request = URLRequest(url: url)
        let cachedURLResponse = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedURLResponse, for: request)
    }
}
