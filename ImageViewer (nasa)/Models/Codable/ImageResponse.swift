//
//  ImageResponse.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

struct ImageResponse: Decodable {
    let id: String
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
