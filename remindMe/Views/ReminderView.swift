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
    
    var title: String!
    
    
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
        
        
       
        
        let name = CustomLable(fontSize: 20, text: reminder.name!, textColor: UIColor.black)
        let time = CustomLable(fontSize: 10, text: "every " + reminder.groupId , textColor: UIColor.darkGray)
        
        let descr = CustomLable(fontSize: 11, text: reminder.description ?? "", textColor: UIColor.black)
        
        descr.numberOfLines = 0
        
        self.addSubview(name)
//        name.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
//        name.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
//
//       name.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        self.addSubview(time)

       
        self.addSubview(descr)
        
      
        descAutoLayout(desc: descr)
      nameAutoLayout(name: name, desc: descr)
        time.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5).isActive = true
        time.leftAnchor.constraint(lessThanOrEqualTo: self.leftAnchor, constant: 15).isActive = true
    }
    private func nameAutoLayout(name: CustomLable, desc: CustomLable){
        let r = frame.width - ((frame.width/2) - 40)
        name.anchor(top: self.topAnchor,
                    left: self.leftAnchor,
                    bottom: self.bottomAnchor,
                    right: self.rightAnchor,
                    paddingTop: 0,
                    paddingLeft: 15,
                    paddingBottom: 25,
                    paddingRight: r,
                    width: frame.width - desc.frame.width - 10,
                    height: frame.height,
                    enableInsets: false)
        
    }
    private func descAutoLayout(desc: CustomLable){
        
        let w = frame.width - ((frame.width / 2) - 10)
        desc.anchor(top: self.topAnchor,
                    left: self.leftAnchor,
                    bottom: self.bottomAnchor,
                    right: self.rightAnchor,
                    paddingTop: 0,
                    paddingLeft: (self.frame.width / 2) - 10,
                    paddingBottom: 0,
                    paddingRight: 0,
                    width: w,
                    height: frame.height,
                    enableInsets: false)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print(rect.size.width)
        let midRect = CGRect(x: (rect.size.width/2) - 40 , y: rect.origin.y + 5, width: 2, height: rect.size.height - 10)
        
        UIColor.gray.set()
        UIRectFill(midRect)
        
    }
}
