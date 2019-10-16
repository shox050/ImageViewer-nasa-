//
//  ImageParsable.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

protocol ImageParsable {
    func parse(fromData data: Data) -> UIImage?
}
