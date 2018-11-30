//
//  CreateGroupViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/20/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class CreateGroupViewController: UIViewController{
// This View Controller class handles functionality to create a new group
    

    var group: Group?
    var mainStackView = UIStackView()
    var groupNameItemsStackView = UIStackView()
    var groupDescriptionItemsStackView = UIStackView()
    var groupAddressItemsStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        anchorPopUpContainer()
        anchorMainStackView()
        anchorGroupNameItems()
        anchorGroupDescriptionItems()
        anchorGroupAddressItems()
    }
    
    var popUpContainer: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.shadowRadius = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let groupNameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Name"
        label.textColor = .gloomyBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let groupNameTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Name..."
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let groupDescriptionLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Description"
        label.textColor = .gloomyBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let groupDescriptionTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Description..."
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let groupAddressLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Address"
        label.textColor = .gloomyBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let groupAddressTextField: UITextField = {
        
        let textField = UITextField()
        textField.placeholder = "Address..."
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    fileprivate func anchorPopUpContainer(){
        
        view.addSubview(popUpContainer)
        NSLayoutConstraint.activate([popUpContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     popUpContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     popUpContainer.widthAnchor.constraint(equalToConstant: self.view.frame.height/3),
                                     popUpContainer.heightAnchor.constraint(equalToConstant: self.view.frame.width/2)])
    }
    
    fileprivate func anchorMainStackView(){
        mainStackView = UIStackView(arrangedSubviews: [groupNameItemsStackView, groupDescriptionTextField, groupAddressItemsStackView])
        mainStackView.alignment = .center
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        popUpContainer.addSubview(mainStackView)
        
        mainStackView.anchor(top: popUpContainer.topAnchor, left: popUpContainer.leftAnchor, bottom: popUpContainer.bottomAnchor, right: popUpContainer.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    }
    fileprivate func anchorGroupNameItems(){
        
        groupNameItemsStackView = UIStackView(arrangedSubviews: [groupNameLabel, groupNameTextField])
        groupNameItemsStackView.alignment = .center
        groupNameItemsStackView.axis = .horizontal
        groupNameItemsStackView.distribution = .fillEqually
        groupNameItemsStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addSubview(groupNameItemsStackView)
        
        
        groupNameItemsStackView.anchor(top: mainStackView.topAnchor, left: mainStackView.leftAnchor, bottom: nil, right: mainStackView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        groupNameLabel.anchor(top: groupNameItemsStackView.topAnchor, left: groupNameItemsStackView.leftAnchor, bottom: groupNameItemsStackView.bottomAnchor, right: groupNameTextField.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)

        groupNameTextField.anchor(top: groupNameItemsStackView.topAnchor, left: groupNameLabel.rightAnchor, bottom: groupNameItemsStackView.bottomAnchor, right: groupNameItemsStackView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    fileprivate func anchorGroupDescriptionItems(){
        
        groupDescriptionItemsStackView = UIStackView(arrangedSubviews: [groupDescriptionLabel, groupNameTextField])
        groupDescriptionItemsStackView.alignment = .center
        groupDescriptionItemsStackView.axis = .horizontal
        groupDescriptionItemsStackView.distribution = .fillEqually
        groupDescriptionItemsStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addSubview(groupDescriptionItemsStackView)
        
        groupDescriptionItemsStackView.anchor(top: groupNameItemsStackView.bottomAnchor, left: mainStackView.leftAnchor, bottom: groupAddressItemsStackView.topAnchor, right: mainStackView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        groupDescriptionTextField.anchor(top: groupDescriptionItemsStackView.topAnchor, left: groupDescriptionItemsStackView.leftAnchor, bottom: groupDescriptionItemsStackView.bottomAnchor, right: groupDescriptionTextField.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)

        groupDescriptionTextField.anchor(top: groupDescriptionItemsStackView.topAnchor, left: groupDescriptionLabel.rightAnchor, bottom: groupDescriptionItemsStackView.bottomAnchor, right: groupDescriptionItemsStackView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    
    }
    
    fileprivate func anchorGroupAddressItems(){
        
        groupAddressItemsStackView = UIStackView(arrangedSubviews: [groupAddressLabel, groupAddressTextField])
        groupAddressItemsStackView.axis = .horizontal
        groupAddressItemsStackView.alignment = .center
        groupAddressItemsStackView.distribution = .fillEqually
        groupAddressItemsStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addSubview(groupAddressItemsStackView)
        
        groupAddressItemsStackView.anchor(top: groupDescriptionItemsStackView.bottomAnchor, left: mainStackView.leftAnchor, bottom: mainStackView.bottomAnchor, right: mainStackView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
        
        groupAddressLabel.anchor(top: groupAddressItemsStackView.topAnchor, left: groupAddressItemsStackView.leftAnchor, bottom: groupAddressItemsStackView.bottomAnchor, right: groupAddressTextField.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)

        groupAddressTextField.anchor(top: groupAddressItemsStackView.topAnchor, left: groupAddressLabel.rightAnchor, bottom: groupAddressItemsStackView.bottomAnchor, right: groupAddressItemsStackView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)


    }
}
