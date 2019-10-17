//
//  ImagesViewModel.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ImagesViewModel {
    
    var nasaImages: [Image] = []
    var selectedNasaImage: Image? = nil
    
    private let networkService: NetworkRequestable = NetworkService()
    private let nasaImageConverter: NasaImageConvertable = NasaImageConverter()
    private let imageParser: ImageParsable = ImageParser()
    private let imageQueue = DispatchQueue(label: "ImageQueue", qos: .userInitiated, attributes: .concurrent)
    
    
}


// MARK: - NasaImagesModel
extension ImagesViewModel {
    
    func getNasaImages(_ completion: @escaping () -> Void) {
        
        networkService.getNasaImages { [weak self] response in
            
            switch response {
            case .failure(let error):
                print("Method getImages got error in response: ", error)
                
            case .success(let data):
                print("Method getImage got data")
                
                let jsonDecoder = JSONDecoder()
                
                do {
                    let nasaImagesResponse = try jsonDecoder.decode([ImageResponse].self, from: data)
                    
                    self?.nasaImages = nasaImagesResponse.compactMap { [weak self] in
                        self?.nasaImageConverter.convert($0)
                    }
                    
                    completion()
                } catch let error {
                    print("Method getImages in NasaImagesViewModel got error: ", error)
                }
            }
        }
    }
    
    func downloadImageFor(nasaImage: Image, _ completion: @escaping (Int) -> Void) {
        
        
        networkService.downloadImage(byPath: nasaImage.imageUrl) { [weak self] response in
            
            switch response {
            case .failure(let error):
                print("Method downloadImageFor nasaImage gor error in response: ", error)
                
            case .success(let data):
                let image = self?.imageParser.parse(fromData: data)
                
                
                self?.imageQueue.async(flags: .barrier) {
                    guard let index = self?.nasaImages.firstIndex(where: {
                        $0.id == nasaImage.id
                    }) else {
                        return
                    }
                    self?.nasaImages[index].image = image
                    completion(index)
                }
            }
        }
    }
}