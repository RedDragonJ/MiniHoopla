//
//  NetworkInterfaces.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

import Foundation

protocol NetworkInterface {
    func fetchData(url: URL) async throws -> Data
}
