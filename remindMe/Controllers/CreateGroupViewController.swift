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
    
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupAddressTextField: UITextField!
    var group: Group?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupNameTextField.delegate = self as UITextFieldDelegate
        groupAddressTextField.delegate = self as UITextFieldDelegate
        
    }
}
