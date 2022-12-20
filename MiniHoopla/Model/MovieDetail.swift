//
//  MovieDetail.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

struct MovieDetail: Codable, Identifiable, Hashable {
    var id: Int
    var genres: [Genre]
    var synopsis: String
        
    enum CodingKeys: String, CodingKey {
        case id
        case genres
        case synopsis
    }
}

struct Genre: Codable, Hashable {
    var id: Int
    var kindId: Int
    var name: String
    var hasChildren: Bool
}
