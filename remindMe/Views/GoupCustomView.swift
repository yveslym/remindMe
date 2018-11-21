//
//  GoupCustomView.swift
//  remindMe
//
//  Created by Yves Songolo on 11/21/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation

import UIKit

/// snippet code for custom view

class CustomView: UIView {
    
    private var sideViewColor: UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
    }
    convenience init(frame: CGRect, leftViewColor: UIColor) {
        self.init(frame: frame)
        sideViewColor = leftViewColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        /// ceate the left view and redraw the view
        
        let leftRect = CGRect(x: rect.origin.x, y: rect.origin.y, width: rect.size.width/4, height: rect.size.height)
        
        
        self.sideViewColor.set()
        UIRectFill(leftRect)
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft, .topLeft], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        
        self.layer.backgroundColor = UIColor.green.cgColor
        self.layer.mask = rectShape
    }
    
}

