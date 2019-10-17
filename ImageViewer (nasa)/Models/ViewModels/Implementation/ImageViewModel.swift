//
//  ImageViewModel.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ImageViewModel {
    
    private var nasaImage: Image!
    
    var image: UIImage? {
        return nasaImage.image
    }
    
    init(_ nasaImage: Image) {
        self.nasaImage = nasaImage
    }
}
