//
//  CreateGroupViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/20/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class CreateGroupViewController: UIViewController{
// This View Controller class handles functionality to create a new group
    
    var group: Group?
    var titleLabel = CustomLabel()
    var groupNameTextField =  CustomTextField()
    var groupAddressTextField = CustomTextField()
    var groupDescriptionLabel = CustomLabel()
    var groupDescriptionTextView = UITextView()
    var saveButton = CustomButton()
    var popUpContainer = UIView()
    var mainStackView = CustomStack()
    var groupDescriptionStackView = CustomStack()
    var mapView: MKMapView!
    var locationManager = AppDelegate.shared.locationManager
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        
        setUpPopUpContainer()
        setUpTitleLabel()
        setUpMapview()
        setUpGroupNameTextFiled()
        setUpGroupAddressTextfield()
        setUpGroupDescriptionTextView()
        setUpSaveButton()
        mainStackViewAutoLayout()
        addSwipeToDismis()
        setUpUpdateGroup()
    }
    
    // MARK : CLASS METHODS
    
    
    @objc fileprivate func saveButtonTapped(sender: UIButton){
        
        
        guard let address = groupAddressTextField.text, let name = groupNameTextField.text, let description = groupDescriptionTextView.text else {return}
        
        GeoFence.shared.addressToCoordinate(address) { (coordinates) in
            if let coordinates = coordinates{

                let latitude = coordinates.latitude
                let longitude = coordinates.longitude
                var createdGroup = Group(id: "", name: name, description: description, latitude: latitude, longitude: longitude)
                createdGroup.address = address
                
                if self.group != nil{
                    if let unwrappedGroup = self.group {
                        createdGroup.id = unwrappedGroup.id
                        GroupServices.update(createdGroup)
                        self.dismiss(animated: true, completion: nil)
                        return
                    }
                }
                
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

    
    // MARK : UI Methods

    fileprivate func setUpMapview(){

        mapView = MKMapView.init()
        mapView.showsUserLocation = true
        mapView.delegate = self

        let center =  locationManager?.location?.coordinate
        let region =  MKCoordinateRegionMakeWithDistance(center!, 400, 400)
        mapView.setRegion(region, animated: true)
        mapView.userTrackingMode = .follow
    }
    
    fileprivate func setUpUpdateGroup(){

        groupNameTextField.text = self.group?.name ?? ""
        groupAddressTextField.text = self.group?.address ?? ""
        groupDescriptionTextView.text = self.group?.description ?? ""
    }
    fileprivate func setUpPopUpContainer(){
        
        popUpContainer = UIView(frame: view.frame)
        popUpContainer.backgroundColor = .white
        popUpContainer.layer.cornerRadius = 15
        popUpContainer.clipsToBounds = true
        popUpContainer.layer.masksToBounds = true
        popUpContainer.layer.shadowRadius = 1
        popUpContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popUpContainer)
    }
    
    fileprivate func setUpTitleLabel(){
        
        titleLabel = CustomLabel(fontSize: 20, text: "New Group", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))
        titleLabel.textAlignment = .center
    }
    
    
    fileprivate func setUpGroupNameTextFiled(){
        
        groupNameTextField = CustomTextField(placeHolder: "Home",
                                             border: 1,
                                             cornerRadius: 5,
                                             borderColor: #colorLiteral(red: 0.07895455509, green: 0.1626217663, blue: 0.2949268222, alpha: 1),
                                             textColor: #colorLiteral(red: 0.07895455509, green: 0.1626217663, blue: 0.2949268222, alpha: 1),
                                             alignment: .left,
                                             borderStyle: .none)
    }
    
    fileprivate func setUpGroupAddressTextfield(){
        
        groupAddressTextField = CustomTextField(placeHolder: "555 post st, San Francisco, CA",
                                                border: 1,
                                                cornerRadius: 5,
                                                borderColor: #colorLiteral(red: 0.07895455509, green: 0.1626217663, blue: 0.2949268222, alpha: 1),
                                                textColor: #colorLiteral(red: 0.07895455509, green: 0.1626217663, blue: 0.2949268222, alpha: 1),
                                                alignment: .left,
                                                borderStyle: .none)
        groupAddressTextField.delegate = self
    }

    fileprivate func setUpGroupDescriptionTextView(){
        
        groupDescriptionLabel = CustomLabel(fontSize: 12, text: "Description", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))
        groupDescriptionTextView.layer.masksToBounds = false
        groupDescriptionTextView.layer.cornerRadius = 10
        groupDescriptionTextView.text = ""
        groupDescriptionTextView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 0.09685359589)
        
        groupDescriptionStackView = CustomStack(subview: [groupDescriptionLabel, groupDescriptionTextView],
                                                alignment: .leading,
                                                axis: .vertical,
                                                distribution: .fill)
        NSLayoutConstraint.activate([groupDescriptionLabel.heightAnchor.constraint(equalTo: groupDescriptionStackView.heightAnchor, multiplier:                             0.2),
                                     groupDescriptionTextView.heightAnchor.constraint(equalTo: groupDescriptionStackView.heightAnchor, multiplier: 0.8),
                                     groupDescriptionTextView.widthAnchor.constraint(equalTo: groupDescriptionStackView.widthAnchor, multiplier: 1),
                                     ])
    }
    
    fileprivate func setUpSaveButton(){
        
        saveButton = CustomButton(title: "Save",
                                  fontSize: 12,
                                  titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                  target: self,
                                  action: #selector(saveButtonTapped(sender:)),
                                  event: .touchUpInside)
        saveButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
    }
    
    fileprivate func mainStackViewAutoLayout(){
        
        mainStackView = CustomStack(subview: [titleLabel, groupNameTextField, groupAddressTextField, groupDescriptionStackView, mapView ,saveButton],
                                    alignment: .center,
                                    axis: .vertical,
                                    distribution: .fill)
        mainStackView.spacing = 5
        popUpContainer.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([popUpContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                                     popUpContainer.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
                                     popUpContainer.widthAnchor.constraint(equalToConstant: self.view.frame.height/2),
                                     popUpContainer.heightAnchor.constraint(equalToConstant: self.view.frame.height/1.3),
                                     mainStackView.topAnchor.constraint(equalTo: popUpContainer.safeAreaLayoutGuide.topAnchor, constant: 10),
                                     mainStackView.leadingAnchor.constraint(equalTo: popUpContainer.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                                     mainStackView.trailingAnchor.constraint(equalTo: popUpContainer.safeAreaLayoutGuide.trailingAnchor, constant: 10),
                                     mainStackView.heightAnchor.constraint(equalTo: popUpContainer.safeAreaLayoutGuide.heightAnchor, multiplier: 0.95),
                                     mainStackView.widthAnchor.constraint(equalTo: popUpContainer.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
                                     titleLabel.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.085),
                                     groupNameTextField.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.09),
                                     groupNameTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.9),
                                     groupAddressTextField.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.09),
                                     groupAddressTextField.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.9),
                                     groupDescriptionStackView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.2),
                                     groupDescriptionStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.9),
                                     mapView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor, multiplier: 0.4),
                                      mapView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.9),

                                     saveButton.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.5)
            ])
    }

}

extension CreateGroupViewController: MKMapViewDelegate{

}
extension CreateGroupViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        GeoFence.shared.addressToCoordinate(textField.text!) { (coordinate) in

            let center =  coordinate
            let region =  MKCoordinateRegionMakeWithDistance(center!, 200, 200)
            self.mapView.setRegion(region, animated: true)
            //self.mapView.userTrackingMode = .follow

            // add annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate!
            annotation.title = self.groupNameTextField.text!
            self.mapView.addAnnotation(annotation)

            
        }
    }
}
