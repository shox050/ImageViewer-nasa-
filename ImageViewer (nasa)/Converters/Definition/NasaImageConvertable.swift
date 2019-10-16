//
//  NasaImageConvertable.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

protocol NasaImageConvertable {
    func convert(_ nasaImageResponse: NasaImageResponse) -> NasaImage
}
