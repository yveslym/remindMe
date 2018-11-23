//
//  NewReminderViewController.swift
//  remindMe
//
//  Created by Yves Songolo on 11/23/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit

class NewReminderViewController: UIViewController {

    // - Mark: Properties
    var titleLabel: CustomLable!
    var reminderNameTextFiled: CustomTextField!
    var reminderDescriptionTextView: UITextView!
    var typeEntryButton: customButton!
    var typeExitButton: customButton!
    var typeLabel: CustomLable!
    var dateTimeLabel: CustomLable!
    var dayPickerView: UIPickerView!
    var timeFromPickerView: UIDatePicker!
    var timeToPickerView: UIDatePicker!
    var doneButton: customButton!
    var mainView: UIView!
    var userGroup: Group!
    var newReminder: Reminder!
    var pickedDay: String = "Monday"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        setupMainView()
        setupTitle()
        setupReminderTextField()
        setupTypeButton()
        setUpDateTimeLabel()
        setupDateSelectionPicker()
    }
    
    func setupMainView(){
      
        mainView = UIView(frame: view.frame)
       view.addSubview(mainView)
        mainView.anchor(top: view.topAnchor,
                        left: view.leftAnchor,
                        bottom: view.bottomAnchor,
                        right: view.rightAnchor,
                        paddingTop: view.frame.height/7,
                        paddingLeft: view.frame.width/15,
                        paddingBottom: view.frame.height/10,
                        paddingRight: view.frame.width/15,
                        width: 0,
                        height: 0,
                        enableInsets: true)
        
        mainView.backgroundColor = UIColor.white
        mainView.layer.masksToBounds = false
        mainView.layer.cornerRadius = 10
    }
    
    func setupTitle(){
        titleLabel = CustomLable(fontSize: 20, text: "New \(userGroup.name) Reminder", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))
        mainView.addSubview(titleLabel)
        titleLabel.anchor(top: mainView.topAnchor,
                          left: mainView.leftAnchor,
                          bottom: nil,
                          right: mainView.rightAnchor,
                          paddingTop: 5,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0,
                          height: 0,
                          enableInsets: true)
    }

    func setupReminderTextField(){
        reminderNameTextFiled = CustomTextField(placeHolder: "Title", border: 1, cornerRadius: 5, borderColor: #colorLiteral(red: 0.07895455509, green: 0.1626217663, blue: 0.2949268222, alpha: 1), textColor: #colorLiteral(red: 0.07895455509, green: 0.1626217663, blue: 0.2949268222, alpha: 1), alignment: .left, borderStyle: .none)
        
        mainView.addSubview(reminderNameTextFiled)
        reminderNameTextFiled.anchor(top: titleLabel.bottomAnchor,
                                     left: mainView.leftAnchor,
                                     bottom: nil,
                                     right: mainView.rightAnchor,
                                     paddingTop: 40,
                                     paddingLeft: 10,
                                     paddingBottom: 0,
                                     paddingRight: 10,
                                     width: mainView.frame.width - 10,
                                     height: 0,
                                     enableInsets: true)
    
    }
    func setupTypeButton(){
        typeEntryButton = customButton(title: "Entry", fontSize: 12, titleColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), target: self, action: #selector(selectTypeButtonTapped(sender:)), event: .touchUpInside)
        typeEntryButton.tag = 1
        
        typeExitButton =  customButton(title: "Exit", fontSize: 12, titleColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), target: self, action: #selector(selectTypeButtonTapped(sender:)), event: .touchUpInside)
        typeExitButton.tag = 2
        
        dateTimeLabel = CustomLable(fontSize: 14, text: "Reminder Type: ", textColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
        
       
        let buttomStack = customStack.init(subview: [typeEntryButton,typeExitButton], alignment: .center, axis: .horizontal, distribution: .fillEqually)
        buttomStack.spacing = 10
        
         let stack = customStack(subview: [dateTimeLabel,buttomStack], alignment: .fill, axis: .horizontal, distribution: .fill)
        
        mainView.addSubview(stack)
        
        stack.anchor(top: reminderNameTextFiled.bottomAnchor,
                     left: mainView.leftAnchor,
                     bottom: nil,
                     right: mainView.rightAnchor,
                     paddingTop: 20,
                     paddingLeft: 10,
                     paddingBottom: 0,
                     paddingRight: 10,
                     width: 0,
                     height: 0,
                     enableInsets: true)
        dateTimeLabel.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 0.5).isActive = true
   
        typeEntryButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
        typeEntryButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        typeExitButton.newLayerColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        typeExitButton.setTitleColor(#colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1), for: .normal)
    
    }
    
    func setUpDateTimeLabel(){
        let stack = mainView.subviews.last
        dateTimeLabel = CustomLable(fontSize: 18, text: "Date and Time", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))
        mainView.addSubview(dateTimeLabel)
        dateTimeLabel.anchor(top: stack?.bottomAnchor,
                             left: mainView.leftAnchor,
                             bottom: nil,
                             right: mainView.rightAnchor,
                             paddingTop: 20,
                             paddingLeft: 10,
                             paddingBottom: 0,
                             paddingRight: 10,
                             width: 0,
                             height: 0,
                             enableInsets: true)
    }
    func  setupDateSelectionPicker(){
        
        dayPickerView = UIPickerView()
        dayPickerView.delegate = self
        dayPickerView.dataSource = self
        
        timeFromPickerView = UIDatePicker()
        timeFromPickerView.datePickerMode = .time
        
        timeToPickerView = UIDatePicker()
        timeToPickerView.datePickerMode = .time
        
        let every = CustomLable(fontSize: 10, text: "Every", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))
        let from = CustomLable(fontSize: 10, text: "From", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))
        let to = CustomLable(fontSize: 10, text: "To", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))
        
        let supportStack = customStack(subview: [every,from,to], alignment: .center, axis: .horizontal, distribution: .fillEqually)
        let pickerStack = customStack(subview: [dayPickerView,timeFromPickerView,timeToPickerView], alignment: .center, axis: .horizontal, distribution: .fillEqually)
        let stack = customStack(subview: [supportStack,pickerStack], alignment: .center, axis: .vertical, distribution: .fill)
        mainView.addSubview(stack)
        
        stack.anchor(top: dateTimeLabel.bottomAnchor,
                     left: mainView.leftAnchor,
                     bottom: nil,
                     right: mainView.rightAnchor,
                     paddingTop: 10,
                     paddingLeft: 0,
                     paddingBottom: 0,
                     paddingRight: 0,
                     width: 0,
                     height: 0,
                     enableInsets: true)
        supportStack.heightAnchor.constraint(equalTo: stack.heightAnchor, multiplier: 0.2).isActive = true
        supportStack.widthAnchor.constraint(equalTo: stack.widthAnchor, multiplier: 1).isActive = true
    }
    
    @objc func selectTypeButtonTapped(sender: customButton){
        
        switch sender.tag{
        case 1:
            typeEntryButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
            typeEntryButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            
            typeExitButton.newLayerColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            typeExitButton.setTitleColor(#colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1), for: .normal)
            
        case 2:
            typeEntryButton.newLayerColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            typeEntryButton.setTitleColor(#colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1), for: .normal)
            
            typeExitButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
            typeExitButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        default: break
        }
    }
  
}

extension NewReminderViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return Constant.days.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constant.days[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       self.pickedDay = Constant.days[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "<Your Font Name>", size: 10)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = Constant.days[row]
        pickerLabel?.textColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
        return pickerLabel!
    }
    
}
