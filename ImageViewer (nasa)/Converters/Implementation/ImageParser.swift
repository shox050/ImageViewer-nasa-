//
//  ImageParser.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ImageParser: ImageParsable {
    func parse(fromData data: Data) -> UIImage? {
                        
        guard let compressedData = UIImage(data: data)?.jpegData(compressionQuality: 0.4), let image = UIImage(data: compressedData) else {
            print("ImageParser cant get image from data")
            return nil
        }
        
        return image
    }
}
