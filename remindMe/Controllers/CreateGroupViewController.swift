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
    var titleLabel = CustomLabel()
    var groupNameLabel = CustomLabel()
    var groupDescriptionLabel = CustomLabel()
    var groupAddressLabel = CustomLabel()
    var groupNameTextField =  CustomTextField()
    var groupDescriptionTextField = CustomTextField()
    var groupAddressTextField = CustomTextField()
    var saveButton = CustomButton()
    var popUpContainer = UIView()
    var mainStackView = CustomStack()
    var groupNameItemsStackView = CustomStack()
    var groupDescriptionItemsStackView = CustomStack()
    var groupAddressItemsStackView = CustomStack()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        anchorPopUpContainer()
        anchorMainStackView()
        anchorTitleLabel()
        anchorGroupNameItems()
        anchorGroupDescriptionItems()
        anchorGroupAddressItems()
        anchorSaveButton()
        addSwipeToDismis()
    }
    
    @objc fileprivate func saveButtonTapped(sender: UIButton){
        guard let address = groupAddressTextField.text, let name = groupNameTextField.text, let description = groupDescriptionTextField.text else {return}
        GeoFence.shared.addressToCoordinate(address) { (coordinates) in
            if let coordinates = coordinates{
                
                let latitude = coordinates.latitude
                let longitude = coordinates.longitude
                let createdGroup = Group(id: "", name: name, description: description, latitude: latitude, longitude: longitude)
                GroupServices.create(createdGroup, completion: { (newGroup) in
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    fileprivate func addSwipeToDismis() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleMainViewDragged(_:)))
        popUpContainer.addGestureRecognizer(gestureRecognizer)
    }
    

    @objc func handleMainViewDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            let translation = gestureRecognizer.translation(in: self.view)
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        if gestureRecognizer.state == .ended{
            self.dismiss(animated: true, completion: nil)
        }
    }

    fileprivate func anchorPopUpContainer(){
        
        popUpContainer = UIView(frame: view.frame)
        view.addSubview(popUpContainer)
        NSLayoutConstraint.activate([popUpContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     popUpContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     popUpContainer.widthAnchor.constraint(equalToConstant: self.view.frame.height/3),
                                     popUpContainer.heightAnchor.constraint(equalToConstant: self.view.frame.width/2)])
        
        popUpContainer.backgroundColor = .white
        popUpContainer.layer.cornerRadius = 15
        popUpContainer.clipsToBounds = true
        popUpContainer.layer.masksToBounds = true
        popUpContainer.layer.shadowRadius = 1
        popUpContainer.translatesAutoresizingMaskIntoConstraints = false
    }
    
    fileprivate func anchorMainStackView(){
        mainStackView = CustomStack(subview: [titleLabel, groupNameItemsStackView, groupDescriptionItemsStackView, groupAddressItemsStackView, saveButton],
                                    alignment: .center,
                                    axis: .horizontal,
                                    distribution: .fillEqually)
        popUpContainer.addSubview(mainStackView)
        mainStackView.anchor(top: popUpContainer.topAnchor,
                             left: popUpContainer.leftAnchor,
                             bottom: popUpContainer.bottomAnchor,
                             right: popUpContainer.rightAnchor,
                             paddingTop: 0,
                             paddingLeft: 10,
                             paddingBottom: 10,
                             paddingRight: 10,
                             width: 0,
                             height: 0,
                             enableInsets: false)
    }
    
    fileprivate func anchorTitleLabel(){
        
        titleLabel = CustomLabel(fontSize: 20, text: "New Group", textColor: .gloomyBlue)
        mainStackView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: groupNameItemsStackView.topAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: mainStackView.topAnchor).isActive = true
        
    }
    
    
    fileprivate func anchorGroupNameItems(){
        groupNameLabel = CustomLabel(fontSize: 15, text: "Name", textColor: .gloomyBlue)
        groupNameTextField = CustomTextField(placeHolder: "", border: 0.5, cornerRadius: 5, borderColor: .gray, textColor: .black, alignment: .center, borderStyle: .line)
        
        groupNameItemsStackView = CustomStack(subview: [groupNameLabel, groupNameTextField],
                                              alignment: .center,
                                              axis: .horizontal,
                                              distribution: .fillEqually)
        mainStackView.addSubview(groupNameItemsStackView)


        groupNameItemsStackView.anchor(top: titleLabel.bottomAnchor,
                                       left: mainStackView.leftAnchor,
                                       bottom: nil,
                                       right: mainStackView.rightAnchor,
                                       paddingTop: 0,
                                       paddingLeft: 0,
                                       paddingBottom: 0,
                                       paddingRight: 0,
                                       width: 0,
                                       height: 0,
                                       enableInsets: false)

        groupNameLabel.anchor(top: groupNameItemsStackView.topAnchor,
                              left: groupNameItemsStackView.leftAnchor,
                              bottom: groupNameItemsStackView.bottomAnchor,
                              right: groupNameTextField.leftAnchor,
                              paddingTop: 0,
                              paddingLeft: 0,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 0,
                              height: 0,
                              enableInsets: false)

        groupNameTextField.anchor(top: groupNameItemsStackView.topAnchor,
                                  left: groupNameLabel.rightAnchor,
                                  bottom: groupNameItemsStackView.bottomAnchor,
                                  right: groupNameItemsStackView.rightAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 0,
                                  paddingBottom: 0,
                                  paddingRight: 0,
                                  width: 0,
                                  height: 0,
                                  enableInsets: false)
    }

    fileprivate func anchorGroupDescriptionItems(){
        groupDescriptionLabel = CustomLabel(fontSize: 15, text: "Description", textColor: .gloomyBlue)
        
        groupDescriptionTextField = CustomTextField(placeHolder: "",
                                                    border: 0.5,
                                                    cornerRadius: 5,
                                                    borderColor: .gray,
                                                    textColor: .black,
                                                    alignment: .center,
                                                    borderStyle: .line)
        groupDescriptionItemsStackView =  CustomStack(subview: [groupDescriptionLabel, groupDescriptionTextField],
                                                      alignment: .center,
                                                      axis: .horizontal,
                                                      distribution: .fillEqually)

        mainStackView.addSubview(groupDescriptionItemsStackView)

        groupDescriptionItemsStackView.anchor(top: groupNameItemsStackView.bottomAnchor,
                                              left: mainStackView.leftAnchor,
                                              bottom: groupAddressItemsStackView.topAnchor,
                                              right: mainStackView.rightAnchor,
                                              paddingTop: 0,
                                              paddingLeft: 0,
                                              paddingBottom: 0,
                                              paddingRight: 0,
                                              width: 0,
                                              height: 0,
                                              enableInsets: false)

        groupDescriptionLabel.anchor(top: groupDescriptionItemsStackView.topAnchor,
                                         left: groupDescriptionItemsStackView.leftAnchor,
                                         bottom: groupDescriptionItemsStackView.bottomAnchor,
                                         right: groupDescriptionTextField.leftAnchor,
                                         paddingTop: 0,
                                         paddingLeft: 0,
                                         paddingBottom: 0,
                                         paddingRight: 0,
                                         width: 0,
                                         height: 0,
                                         enableInsets: false)

        groupDescriptionTextField.anchor(top: groupDescriptionItemsStackView.topAnchor,
                                         left: groupDescriptionLabel.rightAnchor,
                                         bottom: groupDescriptionItemsStackView.bottomAnchor,
                                         right: groupDescriptionItemsStackView.rightAnchor,
                                         paddingTop: 0,
                                         paddingLeft: 0,
                                         paddingBottom: 0,
                                         paddingRight: 0,
                                         width: 0,
                                         height: 0,
                                         enableInsets: false)

    }

    fileprivate func anchorGroupAddressItems(){
        groupAddressLabel = CustomLabel(fontSize: 15, text: "Address", textColor: .gloomyBlue)
        
        groupAddressTextField = CustomTextField(placeHolder: "",
                                                border: 0.2,
                                                cornerRadius: 5,
                                                borderColor: .lightGray,
                                                textColor: .black,
                                                alignment: .center,
                                                borderStyle: .line)
        groupAddressItemsStackView = CustomStack(subview: [groupAddressLabel, groupAddressTextField],
                                                 alignment: .center,
                                                 axis: .horizontal,
                                                 distribution: .fillEqually)
        
        mainStackView.addSubview(groupAddressItemsStackView)

        groupAddressItemsStackView.anchor(top: groupDescriptionItemsStackView.bottomAnchor,
                                          left: mainStackView.leftAnchor,
                                          bottom: nil,
                                          right: mainStackView.rightAnchor,
                                          paddingTop: 0,
                                          paddingLeft: 0,
                                          paddingBottom: 0,
                                          paddingRight: 0,
                                          width: 0,
                                          height: 0,
                                          enableInsets: false)

        groupAddressLabel.anchor(top: groupAddressItemsStackView.topAnchor,
                                 left: groupAddressItemsStackView.leftAnchor,
                                 bottom: groupAddressItemsStackView.bottomAnchor,
                                 right: groupAddressTextField.leftAnchor,
                                 paddingTop: 0,
                                 paddingLeft: 0,
                                 paddingBottom: 0,
                                 paddingRight: 0,
                                 width: 0,
                                 height: 0,
                                 enableInsets: false)

        groupAddressTextField.anchor(top: groupAddressItemsStackView.topAnchor,
                                     left: groupAddressLabel.rightAnchor,
                                     bottom: groupAddressItemsStackView.bottomAnchor,
                                     right: groupAddressItemsStackView.rightAnchor,
                                     paddingTop: 0,
                                     paddingLeft: 0,
                                     paddingBottom: 0,
                                     paddingRight: 0,
                                     width: 0,
                                     height: 0,
                                     enableInsets: false)
    }
    
    fileprivate func anchorSaveButton(){
        let event = UIControlEvents.touchDown
        saveButton = CustomButton(title: "Save", fontSize: 15, titleColor: .gloomyBlue, target: Any?.self, action: #selector(saveButtonTapped(sender:)), event: event)
        
        mainStackView.addSubview(saveButton)
        saveButton.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor).isActive = true
        saveButton.leftAnchor.constraint(equalTo: mainStackView.leftAnchor, constant: 30).isActive = true
        saveButton.rightAnchor.constraint(equalTo: mainStackView.rightAnchor, constant: -30).isActive = true
    }
}
