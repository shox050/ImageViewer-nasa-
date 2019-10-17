//
//  ImageViewController.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
        
    private var nasaImageViewModel: ImageViewModel!
    
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var ivImage: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ivImage.frame = view.frame
        
        scrollView.minimumZoomScale = Constants.minZoomScale
        scrollView.maximumZoomScale = Constants.maxZoomScale
        
        setup()
    }
    
    private struct Constants {
        static let minZoomScale: CGFloat = 1.0
        static let maxZoomScale: CGFloat = 7.0
    }
}


extension ImageViewController {
    private func setup() {
        guard nasaImageViewModel != nil else {
            print("Error, nasaImageViewModel == nil")
            return
        }
        
        ivImage?.image = nasaImageViewModel.image
    }
}

// MARK: - NasaImageController
extension ImageViewController: ImageController {
    
    func configure(with nasaImage: Image) {
        nasaImageViewModel = ImageViewModel(nasaImage)
        
        setup()
    }
}

// MARK: - UIScrollViewDelegate
extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ivImage
    }
}
