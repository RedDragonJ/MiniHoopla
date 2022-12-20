//
//  Movie.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

struct Movie: Codable, Identifiable, Hashable {
    var id: Int
    var title: String
    var kind: String
    var kindName: String
    var artistName: String
    var demo: Bool
    var productionAssist: Bool
    var edited: Bool
    var artKey: String
    var year: Int
    var children: Bool
    var fixedLayout: Bool
    var readAlong: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "titleId"
        case title
        case kind
        case kindName
        case artistName
        case demo
        case productionAssist = "pa"
        case edited
        case artKey
        case year
        case children
        case fixedLayout
        case readAlong
    }
}
