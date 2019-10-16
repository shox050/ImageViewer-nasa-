//
//  NasaImageResponse.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

struct NasaImageResponse: Decodable {
    let id: Int
    let author: String
    let width: Int
    let height: Int
    let imageUrl: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case imageUrl = "download_url"
    }
}
