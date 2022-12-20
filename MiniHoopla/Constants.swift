//
//  Constants.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

struct K {
    
    struct API {
        static let scheme = "https"
        static let host = "hoopla-ws.hoopladigital.com"
        static let topPath = "/kinds/7/titles/top"
        static let titlesPath = "/titles/"
    }
    
    struct ImageAPI {
        static let scheme = "https"
        static let host = "d2snwnmzyr8jue.cloudfront.net"
        static let path = "/%@_270.jpeg"
    }
    
    struct Alert {
        static let errorTitle = "Error"
    }
}
