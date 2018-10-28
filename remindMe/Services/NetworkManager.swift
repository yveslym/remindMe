//
//  NetworkManager.swift
//  remindMe
//
//  Created by Medi Assumani on 10/28/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import Reachability

class NetworkManager: NSObject{
    /* Implements The Functionality for the device's network status
     
     Methods :
     - networkStatusChanged : updates and notfies status changes
     - stopNotifier - stops the notifier
     - isReachable ; can connect to internet
     - isUnReachable : cannot connect to internet
     - isReachableViaCellular : can connect to internet via cellullar
     - isReachableViaWifi : can connect to internet via wifi
     
     */
    
    var reachability: Reachability!
    static let shared: NetworkManager = NetworkManager()
    
    override init() {
        super.init()
        
        reachability = Reachability()!
        
        // Registers an observer for the network status
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(networkStatusChanged(_:)),
                                               name: .reachabilityChanged,
                                               object: reachability)
    
    // Booting up the notifier after initilizing the object
    do {
        try? reachability.startNotifier()
    } catch {
    print("Error Found : Unable to start notifier")
    }
    
}
    
    //updates and notfies internet status changes
    @objc func networkStatusChanged(_ notification: Notification) {
        
    }
    
    // Stops the notifier from broadcasting
    static func stopNotifier(){
        do{
            try? NetworkManager.shared.reachability.stopNotifier()
        } catch {
            print("Error Found : Error found while stopping Notifier")
        }
    }
    
    // Handles connetion status when it is reachable altogether
    static func isReachable(completion: @escaping (NetworkManager) -> ()) {
        
    }
    
    // Handles connetion status when it is unreachable altogether
    static func isUnReachable(completion: @escaping (NetworkManager) -> ()) {
        if NetworkManager.shared.reachability.connection == .none{
            completion(NetworkManager.shared)
        }
    }
    
    // Handles connetion status when it is reachable via wwan or cellular(phone data)
    static func isReachableViaCellular(completion: @escaping (NetworkManager) -> ()) {
        if NetworkManager.shared.reachability.connection == .cellular{
            completion(NetworkManager.shared)
        }
    }
    
    // Handles connetion status when it is reachable via wifi
    static func isReachableViaWifi(completion: @escaping (NetworkManager) -> ()){
        if NetworkManager.shared.reachability.connection == .wifi{
            completion(NetworkManager.shared)
        }
    }
}

