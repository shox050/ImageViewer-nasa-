//
//  ImageCell.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet private weak var ivImage: UIImageView!
    
}



extension ImageCell: Configurable {
    typealias DataSourceType = Image
    
    func configure(with dataSource: Image) {
        ivImage.image = dataSource.image
    }
}
