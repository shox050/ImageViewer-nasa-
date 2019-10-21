//
//  ImageConverter.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

class ImageConverter: ImageConvertable {
    
    func convert(_ imageResponse: ImageResponse) -> Image {
        let id = imageResponse.id
        let author = imageResponse.author
        let width = imageResponse.width
        let height = imageResponse.height
        let imageUrl = imageResponse.imageUrl
        
        return Image(id: id,
                     author: author,
                     width: width,
                     height: height,
                     imageUrl: imageUrl)
    }
}
