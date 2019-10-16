//
//  NasaImagesModel.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

protocol NasaImagesModel {
    func getNasaImages(_ completion: @escaping () -> Void)
    
    func downloadImageFor(nasaImage: NasaImage, _ completion: @escaping (Int) -> Void)
}
