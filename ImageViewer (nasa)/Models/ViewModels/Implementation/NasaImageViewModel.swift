//
//  NasaImageViewModel.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class NasaImageViewModel {
    
    private var nasaImage: NasaImage!
    
    var image: UIImage? {
        return nasaImage.image
    }
    
    init(_ nasaImage: NasaImage) {
        self.nasaImage = nasaImage
    }
}
