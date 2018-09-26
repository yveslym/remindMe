//
//  CreateReminderViewController+Extension.swift
//  remindMe
//
//  Created by Medi Assumani on 9/24/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import JLocationKit

extension CreateReminderViewController: UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifier = segue.identifier, let destinationViewController = segue.destination as? ReminderListViewController else {return}
        
        switch segueIdentifier {
            
        case Constant.saveReminderSegueIdenfier where reminder == nil:
            guard let name = reminderNameTextField.text, let type = EventType(rawValue: reminderTypeTextFiled.text ?? "none"), let time = reminderTimeTextField.text else {return}
            
            
            var createdReminder = Reminder(name: name, type: type, time: time)
            destinationViewController.userReminders.append(createdReminder)
            
        default:
            print("Unindentified Indentifier")
        }
        
    }
    
    
    
    // FUNCTION TO RETURN THE NUMBER OF COLUMNS TO DISPLAY
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // FUNCTION TO RETURN THE NUMBER OF ROWS IN THE PICKER VIEW
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return typesOfReminders.count
    }
    
    // FUNCTION TO RETURN THE TEXT TO BE SHOWN ON EACH ROW OF THE ENTRY TYPE PICKER VIEW
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return typesOfReminders[row]
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
    
}
