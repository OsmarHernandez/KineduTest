//
//  BuildInfo.swift
//  KineduTest
//
//  Created by Osmar Hernández on 13/02/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation

struct BuildInfo: Decodable {
    let version: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case version
        case releaseDate = "release_date"
    }
}
