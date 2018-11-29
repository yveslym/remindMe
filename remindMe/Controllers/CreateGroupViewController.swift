//
//  CreateGroupViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/20/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class CreateGroupViewController: UIViewController{
// This View Controller class handles functionality to create a new group
    

    var group: Group?
    var mainStackView = UIStackView()
    var groupNameItemsStackView = UIStackView()
    var groupDescriptionItemsStackView = UIStackView()
    var groupAddressItemsStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    let groupNameLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Name"
        label.textColor = .black
        return label
    }()
    
    let groupDescriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Description"
        label.textColor = .black
        return label
    }()
    
    let groupAddressLabel: UILabel = {
        
        let label = UILabel()
        
        label.text = "Address"
        label.textColor = .black
        return label
    }()
    
    let groupNameTextField: UITextField = {
       
        let textField = UITextField()
        
        
        return textField
    }()
    
    let groupDescriptionTextField: UITextField = {
        
        let textField = UITextField()
        
        
        return textField
    }()
    
    let groupAddressTextField: UITextField = {
        
        let textField = UITextField()
        
        return textField
    }()
    
    fileprivate func anchorViews(){
        
        
    }
}
