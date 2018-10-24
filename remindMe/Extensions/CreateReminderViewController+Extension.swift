//
//  CreateReminderViewController+Extension.swift
//  remindMe
//
//  Created by Medi Assumani on 9/24/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

extension CreateReminderViewController: UITextFieldDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifier = segue.identifier, let destinationViewController = segue.destination as? ReminderListViewController else {return}
        
        switch segueIdentifier {
            
        case Constant.saveReminderSegueIdenfier where reminder == nil:
            
            
                  guard let groupId = destinationViewController.parentGroup?.id,
                  let latitude = destinationViewController.parentGroup?.latitude,
                     let name = reminderNameTextField.text,
                  let longitude = destinationViewController.parentGroup?.longitude else {return}
                let time = reminderDatePiker.date.toString()
                  
                  let index = reminderTypeSegmentControl.selectedSegmentIndex
                  let type = (index == 0) ? ( EventType.onEntry) : ( EventType.onExit)
                  
            let createdReminder = Reminder(groupId: groupId, id: "", name: name, type: type, time: time, longitude: longitude, latitude: latitude)
            destinationViewController.parentGroup?.numberOfReminders += 1
            ReminderServices.create(createdReminder) {
                print(createdReminder)
            }
            
        default:
            print("Unindentified Indentifier")
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        self.dismiss(animated: animated, completion: nil)
        
    }
    

    // FUNCTION TO SELECT THE NEXT TEXTFIELD TO PROMPT FOR INPUT
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
//        switch textField {
//
//        case reminderNameTextField:
//
//            reminderNameTextField.becomeFirstResponder()
//
//        case reminderTypeTextFiled:
//
//            reminderTimeTextField.becomeFirstResponder()
//
//        default:
//
//            reminderTimeTextField.resignFirstResponder()
//        }
        
        return true
    }
    
}
