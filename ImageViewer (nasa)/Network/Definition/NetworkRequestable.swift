//
//  NetworkRequestable.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation

protocol NetworkRequestable {
    func getImages(_ completion: @escaping (Result<Data, Error>) -> Void)
    
    func downloadImage(byPath path: String, _ completion: @escaping (Result<Data, Error>) -> Void)
}
