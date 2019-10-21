//
//  ImagesViewController .swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 16.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class ImagesViewController: FoundationViewController {
    
    fileprivate struct Constant {
        static let cellIdentifier = "ImageCell"
        static let heightRowScale: CGFloat = 0.7
    }
    
    private var imagesViewModel = ImagesViewModel()
    private var isFirstLaunch = true
    
    @IBOutlet private weak var tvImages: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityDidChange(_:)),
                                               name: ReachabilityObserver.Notification.didChange.name,
                                               object: nil)
        
        ReachabilityObserver.shared.startObserving()
        
        tvImages.rowHeight = view.frame.width * Constant.heightRowScale
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(longPressGestureRecognizer:)))
        tvImages.addGestureRecognizer(longPressRecognizer)
        
        downloadImages()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ImageController else {
            print("failure prepare for segue: destination as ImageController")
            return
        }
        
        guard let selectedImage = imagesViewModel.selectedImage else {
            print("seclectedImage == nil")
            return
        }
        
        destination.configure(with: selectedImage)
    }
    
    deinit {
        ReachabilityObserver.shared.stopObserving()
    }
}


// MARK: - UITableViewDataSource
extension ImagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesViewModel.images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier) as? ImageCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: imagesViewModel.images[indexPath.row])
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension ImagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        imagesViewModel.selectedImage = imagesViewModel.images[indexPath.row]
        
        performSegue(withIdentifier: "showImageViewController", sender: self)
    }
}


// MARK: - Methods
extension ImagesViewController {
    
    private func downloadImages() {
        imagesViewModel.getImages { [weak self] in
            
            guard let this = self else { return }
            
            DispatchQueue.main.sync {
                this.tvImages.reloadData()
            }
            
            this.imagesViewModel.images.forEach { image in
                this.imagesViewModel.downloadImageFor(image: image) { index in
                    DispatchQueue.main.sync {
                        let indexPath = IndexPath(row: index, section: 0)
                        this.tvImages.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        }
    }
    
    @objc private func didLongPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.ended {
            let point = longPressGestureRecognizer.location(in: tvImages)
            guard let indexPath = tvImages.indexPathForRow(at: point) else {
                print("Cant get indexPath by press point")
                return
            }
            print(indexPath)
            
            imagesViewModel.images.remove(at: indexPath.row)
            tvImages.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @objc private func reachabilityDidChange(_ notification: Notification) {
        switch ReachabilityObserver.shared.isReachable {
        case false:
            presentAlert(withTitle: "Network is lost",
                         message: "Data can be updated when the network will be reachable")
        case true:
            guard !isFirstLaunch else {
                isFirstLaunch = false
                return
            }
            
            let actionWillUpdate = UIAlertAction(title: "Update", style: .default) { [weak self] action in
                self?.downloadImages()
            }
            let actionNoUpdate = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            presentAlert(withTitle: "Network is reachable", message: "Data can be update", actions: [actionWillUpdate, actionNoUpdate])
        }
    }
}

