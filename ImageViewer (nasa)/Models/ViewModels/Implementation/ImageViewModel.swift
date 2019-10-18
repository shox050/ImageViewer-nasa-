//
//  ImageViewModel.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ImageViewModel {
    
    private var image: Image!
    
    var picture: UIImage? {
        return image.image
    }
    
    init(_ image: Image) {
        self.image = image
    }
}
