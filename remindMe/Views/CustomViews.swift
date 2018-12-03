//
//  CustomViews.swift
//  remindMe
//
//  Created by Yves Songolo on 11/21/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit
class CustomLabel: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    convenience init(fontSize: CGFloat, text: String, textColor: UIColor) {
        self.init()
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomTextField: UITextField{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(placeHolder: String, border: CGFloat, cornerRadius: CGFloat, borderColor: UIColor, textColor: UIColor, alignment: NSTextAlignment, borderStyle: BorderStyle){
        self.init()
        
        backgroundColor = .clear
        attributedPlaceholder = NSAttributedString(string: placeHolder ,attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
       
        self.borderStyle = borderStyle
        
        if borderStyle != .none{
        layer.borderWidth = border
        layer.borderColor = borderColor.cgColor
         layer.cornerRadius = cornerRadius
        }
        self.textColor = textColor
        textAlignment = alignment
        
       
        translatesAutoresizingMaskIntoConstraints = false
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if borderStyle == .none{
       
        let buttomRect = CGRect(x: rect.origin.x, y: rect.maxY - 2, width: rect.width, height: 1)
        
        UIColor.gray.set()
        UIRectFill(buttomRect)
        }
    }
}



class CustomStack: UIStackView{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init (subview: [UIView], alignment: UIStackView.Alignment, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution){
        self.init(arrangedSubviews: subview)
        self.alignment = alignment
        self.axis = axis
        self.distribution = distribution
        translatesAutoresizingMaskIntoConstraints = false
    }
}

class CustomButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    convenience init(title: String, fontSize: CGFloat, titleColor: UIColor,target: Any?, action: Selector, event: UIControlEvents){
        self.init()
      
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.setTitleColor(titleColor, for: .normal)
       self.addTarget(target, action: action, for: event)
        self.translatesAutoresizingMaskIntoConstraints = false
       self.isEnabled = true
//        layer.cornerRadius = 5
//        layer.masksToBounds = false
//
//        layer.shadowOpacity = 0.5
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowRadius = 5
         self.backgroundColor = UIColor.white
        
        
    }
    var shadowLayer: CAShapeLayer!
    
    var newLayerColor: UIColor = UIColor.white{
        didSet{
            if shadowLayer != nil{
            shadowLayer.fillColor = newLayerColor.cgColor
        }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
            shadowLayer.fillColor = newLayerColor.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.5
            shadowLayer.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
}
