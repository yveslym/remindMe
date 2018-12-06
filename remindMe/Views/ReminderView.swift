//
//  ReminderView.swift
//  remindMe
//
//  Created by Yves Songolo on 11/22/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class ReminderCustomView: CustomView{
    
    private var title: String!
    private var reminderTimeLabel: CustomLabel!
    private var reminderNameLabel: CustomLabel!
    private var reminderDayLabel: CustomLabel!
    private var mainStack: CustomStack!
    private var reminderDescriptionLabel: CustomLabel!
    
    
    private var midRect: CGRect!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, reminder: Reminder){
        
        switch reminder.type{
        case .onEntry?:
            self.init(frame: frame, leftViewColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        case .onExit?:
            self.init(frame: frame, leftViewColor: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1))
        default:
            self.init(frame: frame, leftViewColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
        }
        
        
       
        
        reminderNameLabel = CustomLabel(fontSize: 18, text: reminder.name!, textColor: UIColor.black)
        var day = String()
        (reminder.day == "Every day") ? (day = reminder.day ?? "") : (day = "every  \(reminder.day ?? "")")
        reminderDayLabel = CustomLabel(fontSize: 12, text: day  , textColor: UIColor.darkGray)
        reminderTimeLabel = CustomLabel(fontSize: 10, text: "\(reminder.timeFrom?.toDateTime()?.timeToPrettyString() ?? "") to: \(reminder.timeTo?.toDateTime()?.timeToPrettyString() ?? "")", textColor: UIColor.darkGray)
        
        
        reminderDescriptionLabel = CustomLabel(fontSize: 11, text: reminder.description ?? "", textColor: UIColor.darkGray)
        reminderDescriptionLabel.numberOfLines = 0
        
       
        let stack = CustomStack.init(subview: [reminderNameLabel,reminderDayLabel,reminderTimeLabel], alignment: .fill, axis: .vertical, distribution: .fill)
        reminderNameLabel.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.4).isActive = true
        reminderDayLabel.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.3).isActive = true
        mainStack = CustomStack.init(subview: [stack,reminderDescriptionLabel], alignment: .top, axis: .horizontal, distribution: .fill)
        mainStack.spacing = 10
        
        stack.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.45).isActive = true
        mainStack.frame = self.frame
        self.addSubview(mainStack)
        mainStack.anchor(top: self.topAnchor,
                         left: self.leftAnchor,
                         bottom: self.bottomAnchor,
                         right: self.rightAnchor,
                         paddingTop: 10,
                         paddingLeft: 15,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: 0,
                         height: 0,
                         enableInsets: true)
        
    }
   
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
        midRect = CGRect(x: (rect.size.width/2.1) , y: rect.origin.y + 5, width: 2, height: rect.size.height - 10)
        
        UIColor.gray.set()
        UIRectFill(midRect)
        
    }
}
