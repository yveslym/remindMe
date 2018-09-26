//
//  CreateGroupViewController+Extension.swift
//  remindMe
//
//  Created by Medi Assumani on 9/24/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import JLocationKit

// i dont know why im extending this one to be honest :)

extension CreateGroupViewController: UITextFieldDelegate{
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let segueIdentifier = segue.identifier, let destinationViewController = segue.destination as? GroupListViewController else {return}
        
        switch segueIdentifier {
            
//        // code for when the user taps "save" after making changes to the group attributes
//        case Constant.saveGroupSegueIdentifier where group != nil:
//            return
//
        // code for when the user taps "save" without making any changes to the group attributes
        case Constant.saveGroupSegueIdentifier where group == nil:
            
            guard let address = groupAddressTextField.text else { return }
            GeoFence.addressToCoordinate(address) { (location) in
                if let location = location{
                    
                    let latitude = location.latitude
                    let longitude = location.longitude
                }
            }
            
            
           
            
            
        default:
            return
        }
    }
    
    
    
    
    
    
    
    
    
    // FUNCTION TO HANDLE TEXT FIELDS
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case groupNameTextField:
            
            groupAddressTextField.becomeFirstResponder()
            
        case groupAddressTextField:
            
            groupCityTextField.becomeFirstResponder()
            
        case groupCityTextField:
            
            groupStateTextField.becomeFirstResponder()
            
        default:
            
            groupStateTextField.resignFirstResponder()
        }
        
        return true
    }
}
