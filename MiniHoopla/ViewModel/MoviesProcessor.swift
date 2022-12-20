//
//  MoviesProcessor.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

import SwiftUI

class MoviesProcessor: ObservableObject {
    
    private var networkSession: NetworkInterface
    private var imageRepo: ImageRepoInterface
    
    @Published var movies: [Movie]? = []
    
    init(networkSession: NetworkInterface = NetworkSession(), imageRepo: ImageRepoInterface = ImageRepo()) {
        self.networkSession = networkSession
        self.imageRepo = imageRepo
    }
    
    @MainActor
    func getMovies(_ url: URL?) async throws {
        guard let url = url else {
            throw URLError(.badURL)
        }
        
        let responseData = try await networkSession.fetchData(url: url)
        movies = try JSONDecoder().decode([Movie].self, from: responseData)
    }
    
    @MainActor
    func getMovieDetails(_ url: URL?) async throws -> MovieDetail {
        guard let url = url else {
            throw URLError(.badURL)
        }
        
        let responseData = try await networkSession.fetchData(url: url)
        return try JSONDecoder().decode(MovieDetail.self, from: responseData)
    }
    
    @MainActor
    func getImage(_ url: URL?) async throws -> UIImage {
        guard let url = url else {
            throw URLError(.badURL)
        }
        
        if let image = try await imageRepo.getImage(url: url) {
            return image
        } else {
            return UIImage(systemName: "film")!
        }
    }
}
