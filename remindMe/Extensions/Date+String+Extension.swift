//
//  Date+String+Extension.swift
//  remindMe
//
//  Created by Medi Assumani on 9/28/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

extension String{
    
    // THIS FUNCTION CONVERTS A STRING TO A DATE TYPE
    func stringToDate() -> Date{
        
        let dateFormater =  DateFormatter()
        dateFormater.dateFormat = "HH:mm"
 
        return dateFormater.date(from: self)!
    }
}
