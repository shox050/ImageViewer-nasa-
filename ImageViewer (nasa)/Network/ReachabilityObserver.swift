//
//  ReachabilityObserver.swift
//  ImageViewer (nasa)
//
//  Created by Vladimir on 18.10.2019.
//  Copyright © 2019 VladimirYakutin. All rights reserved.
//

import Foundation
import Alamofire


class ReachabilityObserver {
    static let shared = ReachabilityObserver()
    
    private init() { }
    
    private let manager = NetworkReachabilityManager()
    
    enum Notification: String {
        case didChange = "ReachabilityObserver.didChange"
        
        var name: Foundation.Notification.Name {
            return Foundation.Notification.Name(rawValue)
        }
        
        enum UserInfoKey: String {
            case isReachableKey = "isReachable"
        }
    }
    
    private(set) var isReachable = false
}  

// MARK: - Methods
extension ReachabilityObserver {
    func startObserving() {
        manager?.startListening(onQueue: .global(), onUpdatePerforming: { [weak self] status in
            switch status {
            case .notReachable, .unknown:
                print("The network is not reachable")
                self?.isReachable = false
                self?.notify()
                
            case .reachable:
                print("The network is reachable")
                self?.isReachable = true
                self?.notify()
            }
        })
    }
    
    func stopObserving() {
        manager?.stopListening()
    }
    
    private func notify() {
        NotificationCenter.default.post(name: Notification.didChange.name,
                                        object: self,
                                        userInfo: [Notification.UserInfoKey.isReachableKey.rawValue: isReachable])
    }
}


