//
//  NasaImagesViewController .swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class NasaImagesViewController: UIViewController {
    
    private let nasaImagesViewModel: NasaImagesModel = NasaImagesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

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

// MARK: - UITableViewDelegate
extension NasaImagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        
        print()
    }
}

