//
//  ImageRepoInterfaces.swift
//  MiniHoopla
//
//  Created by James Layton on 12/20/22.
//

import UIKit

protocol ImageRepoInterface {
    func getImage(url: URL) async throws -> UIImage?
    func fetchImage(url: URL) async throws -> UIImage?
}
