//
//  ImageViewController.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
        
    private var imageViewModel: ImageViewModel!
    
    
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
        guard imageViewModel != nil else {
            print("Error, imageViewModel == nil")
            return
        }
        
        ivImage?.image = imageViewModel.picture
    }
}

// MARK: - ImageController
extension ImageViewController: ImageController {
    
    func configure(with image: Image) {
        imageViewModel = ImageViewModel(image)
        
        setup()
    }
}

// MARK: - UIScrollViewDelegate
extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ivImage
    }
}
