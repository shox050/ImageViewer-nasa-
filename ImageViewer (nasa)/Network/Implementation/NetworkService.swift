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
                                               qos: .utility,
                                               attributes: .concurrent)
    
    private func defaultRequest(_ completion: @escaping (AFDataResponse<Data?>) -> Void) {
        
        guard let url = URL(string: Endpoint.basePath) else {
            print("Cant get url from string")
            return
        }
        
        AF.request(url).validate().response(queue: executionQueue) { response in
            completion(response)
        }
    }
}

// MARK: - NetworkRequestable
extension NetworkService: NetworkRequestable {
    
    func getImages(_ completion: @escaping (Result<Data, Error>) -> Void) {
        
        executionQueue.async { [weak self] in
            self?.defaultRequest() { response in
                switch response.result {
                case .success(let data):
                    print("getImages success")
                    
                    guard let data = data else {
                        print("No data from success response")
                        return
                    }
                    
                    completion(.success(data))
                case .failure(let error):
                    print("getImages failure")
                    completion(.failure(error))
                }
            }
        }
    }
    
    func downloadImage(byPath path: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        
        executionQueue.async { [weak self] in
            
            guard let this = self else { return }
            
            guard let url = URL(string: path) else {
                print("Cant get url for get image request")
                return
            }
            AF.request(url)
                .validate()
                .response(queue: this.executionQueue) { response in
                switch response.result {
                case .success(let data):
                    
                    guard let data = data else {
                        print("No data from success response")
                        return
                    }
                    completion(.success(data))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
