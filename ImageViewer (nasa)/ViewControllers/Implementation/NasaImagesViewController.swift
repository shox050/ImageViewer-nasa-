//
//  NasaImagesViewController .swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class NasaImagesViewController: UIViewController {
    
    private var nasaImagesViewModel: NasaImagesModel = NasaImagesViewModel()
    
    @IBOutlet private weak var tvNasaImages: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(longPressGestureRecognizer:)))
        tvNasaImages.addGestureRecognizer(longPressRecognizer)
        
        nasaImagesViewModel.getNasaImages { [weak self] in
            
            DispatchQueue.main.sync {
                self?.tvNasaImages.reloadData()
            }
            
            self?.nasaImagesViewModel.nasaImages.forEach { nasaImage in
                self?.nasaImagesViewModel.downloadImageFor(nasaImage: nasaImage, { index in
                    
                    DispatchQueue.main.async {
                        let indexPath = IndexPath(row: index, section: 0)
                        self?.tvNasaImages.reloadRows(at: [indexPath], with: .automatic)
                    }
                })
            }
        }
    }
}


// MARK: - UITableViewDataSource
extension NasaImagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nasaImagesViewModel.nasaImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NasaImageCell") as? NasaImageCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: nasaImagesViewModel.nasaImages[indexPath.row])
        
        return cell
    }
}


extension NasaImagesViewController {
    @objc func didLongPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.ended {
            let point = longPressGestureRecognizer.location(in: tvNasaImages)
            guard let indexPath = tvNasaImages.indexPathForRow(at: point) else {
                print("Cant get indexPath by press point")
                return
            }
            print(indexPath)
            
            nasaImagesViewModel.nasaImages.remove(at: indexPath.row)
            tvNasaImages.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

