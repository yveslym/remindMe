//
//  CreateGroupViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/20/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit


// This VC is for when a user needs to create a group
class CreateGroupViewController: UIViewController{
    
    
    // - MARK: @IBOULETS AND CLASS PROPERTIES
    
    var group: Group?
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupAddressTextField: UITextField!
    @IBOutlet weak var groupCityTextField: UITextField!
    @IBOutlet weak var groupStateTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupNameTextField.delegate = self as UITextFieldDelegate
        groupAddressTextField.delegate = self as UITextFieldDelegate
        groupCityTextField.delegate = self as UITextFieldDelegate
        groupStateTextField.delegate = self as UITextFieldDelegate
        
    }
}
