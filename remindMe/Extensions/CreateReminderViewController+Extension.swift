//
//  CreateReminderViewController+Extension.swift
//  remindMe
//
//  Created by Medi Assumani on 9/24/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

extension CreateReminderViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    // - MARK: PICKERVIEW AND UITEXTFIELD PROTOCOL FUNCTIONS NEEDED
    
    // FUNCTION TO RETURN THE NUMBER OF COLUMNS TO DISPLAY
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 0
    }
    
    
    // FUNCTION TO RETURN THE NUMBER OF ROWS IN THE PICKER VIEW
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return typesOfReminderList.count
    }
    
    // FUNCTION TO RETURN THE TEXT TO BE SHOWN ON EACH ROW OF THE ENTRY TYPE PICKER VIEW
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return typesOfReminderList[row]
    }
    
    
    // FUNCTION TO SELECT THE NEXT TEXTFIELD TO PROMPT FOR INPUT
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case reminderNameTextField:
            
            reminderTypeTextFiled.becomeFirstResponder()
            
        case reminderTypeTextFiled:
            
            reminderTimeTextField.becomeFirstResponder()
            
        default:
            
            reminderTimeTextField.resignFirstResponder()
        }
        
        return true
    }
    
    
    // - MARK: SEGUE FUNCTIONS
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifier = segue.identifier, let destination = segue.destination as? ReminderListViewController else {return}
        /*
        switch segueIdentifier {
            
        case Constant.saveReminderSegueIdenfier where reminder != nil:
            
            
            
        default:
            print("Unindentified Indentifier")
        }
        */
    }
    
}
