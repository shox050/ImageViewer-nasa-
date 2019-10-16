//
//  NetworkService.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    private let executionQueue = DispatchQueue(label: "NetworkExecutionQueue",
                                               qos: .userInitiated,
                                               attributes: .concurrent)
    
    private func defaultRequest(_ endpoint: Endpoint,
                         _ completion: @escaping (AFDataResponse<Data>) -> Void) {
        
        AF.request(endpoint)
            .validate()
            .responseData { response in
            completion(response)
        }
    }
}

// MARK: - NetworkRequestable
extension NetworkService: NetworkRequestable {
    
    func getNasaImages(_ completion: @escaping (Result<Data, Error>) -> Void) {
        
        executionQueue.async { [weak self] in
            self?.defaultRequest(.nasaImages) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func downloadImage(byPath path: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = URL(string: path) else {
            print("Cant get url for get image request")
            return
        }
        
        executionQueue.async {
            AF.request(url).validate().responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
