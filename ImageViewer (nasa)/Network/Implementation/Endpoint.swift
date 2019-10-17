//
//  Endpoint.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import Alamofire

struct Endpoint {
    
    static let basePath = "https://picsum.photos/v2/list?page=1&limit=20"

}

//// MARK: - URLRequestConvertible
//extension Endpoint: URLRequestConvertible {
//    func asURLRequest() throws -> URLRequest {
//
//        let baseUrl = try Endpoint.basePath.asURL()
//        let url = baseUrl.appendingPathComponent(path)
//        print("URL ", url)
//
//        return URLRequest(url: url)
//    }
//
//}
//
//
//// MARK: - URLConvertible
//extension Endpoint: URLConvertible {
//    func asURL() throws -> URL {
//        return try asURLRequest().url!
//    }
//}
