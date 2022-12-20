//
//  URLComponent+APIBuilder.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

import Foundation

extension URLComponents {
    
    static var components = URLComponents()
    
    static func apiBuilder(titleID: String? = nil) -> URL? {
        components.scheme = K.API.scheme
        components.host = K.API.host
        
        if let titleID {
            components.path = K.API.titlesPath + titleID
        } else {
            components.path = K.API.topPath
        }
        
        return components.url
    }
    
    static func apiBuilder(artKey: String) -> URL? {
        components.scheme = K.ImageAPI.scheme
        components.host = K.ImageAPI.host
        components.path = String(format: K.ImageAPI.path, artKey)
        return components.url
    }
}
