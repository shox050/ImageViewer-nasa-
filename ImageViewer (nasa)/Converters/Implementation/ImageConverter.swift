//
//  ImageConverter.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ImageConverter: NasaImageConvertable {
    
    func convert(_ nasaImageResponse: ImageResponse) -> Image {
        let id = nasaImageResponse.id
        let author = nasaImageResponse.author
        let width = nasaImageResponse.width
        let height = nasaImageResponse.height
        let imageUrl = nasaImageResponse.imageUrl
        
        return Image(id: id,
                         author: author,
                         width: width,
                         height: height,
                         imageUrl: imageUrl)
    }
}
