//
//  FoundationViewController.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 18.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import UIKit

class FoundationViewController: UIViewController {
    
}

// MARK: - Methods
extension FoundationViewController {
    func presentAlert(withTitle title: String,
                      message: String,
                      actions: [UIAlertAction]? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let actions = actions {
            actions.forEach { action in
                alert.addAction(action)
            }
        } else {
            let defaultAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(defaultAction)
        }
        
        DispatchQueue.main.sync {
            present(alert, animated: true)
        }
    }
}
