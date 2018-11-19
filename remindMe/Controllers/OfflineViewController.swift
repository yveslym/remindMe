//
//  OfflineViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 10/28/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class OfflineViewController: UIViewController{
// This View Controller class handles functionality to when the user is offline
    
    let network = NetworkManager.shared
    
    let wifiImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "offline")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(wifiImageView)
        anchorElements()
        
        network.reachability.whenReachable = { reachability in
            self.showMainViewController()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    fileprivate func showMainViewController(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Constant.backToGroupListSegueIdentifier, sender: self)
        }
    }
    
    fileprivate func anchorElements(){
        
        wifiImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 120, paddingLeft: 110, paddingBottom: 0, paddingRight: 110, width: 0, height: 0, enableInsets: false)
        
    }
}
