//
//  ImagesViewModel.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ImagesViewModel {
    
    var images: [Image] = []
    var selectedImage: Image? = nil
    
    private let networkService: NetworkRequestable = NetworkService()
    private let imageConverter: ImageConvertable = ImageConverter()
    private let imageParser: ImageParsable = ImageParser()
    private let imageQueue = DispatchQueue(label: "ImageQueue", qos: .userInitiated, attributes: .concurrent)
    
    
}


extension ImagesViewModel {
    
    func getImages(_ completion: @escaping () -> Void) {
        
        networkService.getImages { [weak self] response in
            
            switch response {
            case .failure(let error):
                print("Method getImages got error in response: ", error)
                
            case .success(let data):
                print("Method getImage got data")
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let imagesResponse = try jsonDecoder.decode([ImageResponse].self, from: data)
                    
                    self?.images = imagesResponse.compactMap { [weak self] in
                        self?.imageConverter.convert($0)
                    }
                    
                    completion()
                } catch let error {
                    print("Method getImages in ImagesViewModel got error: ", error)
                }
            }
        }
    }
    
    func downloadImageFor(image: Image, _ completion: @escaping (Int) -> Void) {
        
        networkService.downloadImage(byPath: image.imageUrl) { [weak self] response in
            
            switch response {
            case .failure(let error):
                print("Method downloadImageFor image got error in response: ", error)
                
            case .success(let data):
                let imageParsed = self?.imageParser.parse(fromData: data)
                
                self?.imageQueue.async(flags: .barrier) {
                    guard let index = self?.images.firstIndex(where: {
                        $0.id == image.id
                    }) else {
                        return
                    }
                    self?.images[index].image = imageParsed
                    completion(index)
                }
            }
        }
    }
}
