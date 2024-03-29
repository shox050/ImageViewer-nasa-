//
//  Configurable.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

protocol Configurable {
    associatedtype DataSourceType
    
    func configure(with dataSource: DataSourceType)
}
