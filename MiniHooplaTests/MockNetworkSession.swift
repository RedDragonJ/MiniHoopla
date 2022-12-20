//
//  MockNetworkSession.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

import UIKit

class MockNetworkSession: NetworkInterface {
    func fetchData(url: URL) async throws -> Data {
        if url.absoluteString == "TestMovie" {
            let movie = Movie(id: 123, title: "TestTitle", kind: "TestKind",
                              kindName: "TestKindName", artistName: "TestArtist",
                              demo: false, productionAssist: false, edited: false,
                              artKey: "TestArtKey", year: 1999, children: true,
                              fixedLayout: true, readAlong: true)
            
            guard let encodedMovie = try? JSONEncoder().encode([movie]) else {
                throw NSError(domain: "com.mocktest",
                              code: 999,
                              userInfo: [NSLocalizedDescriptionKey: "Mock encoding error"])
            }
            
            return encodedMovie
            
        } else if url.absoluteString == "TestMovieDetail" {
            
            let movieDetail = MovieDetail(id: 123, genres: [Genre(id: 123,
                                                                  kindId: 333,
                                                                  name: "TestGenre",
                                                                  hasChildren: false)], synopsis: "TestDescription")
            
            guard let encodedMovieDetail = try? JSONEncoder().encode(movieDetail) else {
                throw NSError(domain: "com.mocktest",
                              code: 999,
                              userInfo: [NSLocalizedDescriptionKey: "Mock encoding error"])
            }
            
            return encodedMovieDetail
            
        } else {
            throw NSError(domain: "com.mocktest",
                                code: 999,
                                userInfo: [NSLocalizedDescriptionKey: "Mock API return an error"])
        }
    }
}
