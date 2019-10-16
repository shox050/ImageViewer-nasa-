//
//  NasaImage.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

struct NasaImage {
    let id: Int
    let author: String
    let width: Int
    let height: Int
    let imageUrl: String
    var image: UIImage? = nil
}
