//
//  NasaImageCell.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class NasaImageCell: UITableViewCell {
    
    @IBOutlet private weak var ivImage: UIImageView!
    
}



extension NasaImageCell: Configurable {
    typealias DataSourceType = NasaImage
    
    func configure(with dataSource: NasaImage) {
        ivImage.image = dataSource.image
    }
}
