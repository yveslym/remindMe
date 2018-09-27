//
//  CreateReminderViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/20/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit


// This VC is for when a user needs to create a reminder
class CreateReminderViewController: UIViewController{
    
    
    // - MARK: @IBOULETS AND PROPERTIES
 
    @IBOutlet weak var reminderNameTextField: UITextField!
    @IBOutlet weak var reminderTypeTextFiled: UITextField!
    @IBOutlet weak var reminderTimeTextField: UITextField!
    var reminder: Reminder?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SETTING UP DELEGATES FOR ALL TEXTFIELDS
        reminderNameTextField.delegate = self as UITextFieldDelegate
        reminderTypeTextFiled.delegate = self as UITextFieldDelegate
        reminderTimeTextField.delegate = self as UITextFieldDelegate
    }
}
