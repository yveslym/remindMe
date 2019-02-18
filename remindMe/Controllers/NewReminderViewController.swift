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
    var titleLabel: CustomLabel!
    var reminderNameTextFiled: CustomTextField!
    var reminderDescriptionTextView: UITextView!
    var typeEntryButton: CustomButton!
    var typeExitButton: CustomButton!
    var saveButton: CustomButton!
    var typeLabel: CustomLabel!
    var dateTimeLabel: CustomLabel!
    var dayPickerView: UIPickerView!
    var timeFromPickerView: UIDatePicker!
    var timeToPickerView: UIDatePicker!
    var doneButton: CustomButton!
    var mainView: UIView!
    var userGroup: Group!
    var newReminder: Reminder!
    var eventType = EventType.onEntry
    var userReminder : Reminder!
    var mainStack: CustomStack!
    var buttonStack: CustomStack!
    var pickerStack: CustomStack!
    var descriptionStack: CustomStack!
    var pickedDay: String = "Monday"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
        setupMainView()
        setupTitle()
        setupReminderTextField()
        setupTypeButton()
        setUpDateTimeLabel()
        setupDateSelectionPicker()
        setupDescriptionTextView()
        setupDoneButton()
        addSwipeToDismis()
        mainStackAutoLayout()
        
        if userReminder != nil{
            setupUpdate()
        }
    }
    
    func setupUpdate(){
        titleLabel.text = userGroup.name
        reminderNameTextFiled.text = userReminder.name
        reminderDescriptionTextView.text = userReminder.description
    }
    
    func setupMainView(){
      
        mainView = UIView(frame: view.frame)
        view.addSubview(mainView)
        mainView.anchor(top: view.topAnchor,
                        left: view.leftAnchor,
                        bottom: view.bottomAnchor,
                        right: view.rightAnchor,
                        paddingTop: view.frame.height/8,
                        paddingLeft: 5,
                        paddingBottom: view.frame.height/8,
                        paddingRight: 5,
                        width: 0,
                        height: 0,
                        enableInsets: true)
        
        mainView.backgroundColor = UIColor.white
        mainView.layer.masksToBounds = false
        mainView.layer.cornerRadius = 10
    }
    
    func setupTitle(){
        titleLabel = CustomLabel(fontSize: 20, text: "New \(userGroup.name) Reminder", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))

        titleLabel.textAlignment = .center
    }
    

    func setupReminderTextField(){
        reminderNameTextFiled = CustomTextField(placeHolder: "Title", border: 1, cornerRadius: 5, borderColor: #colorLiteral(red: 0.07895455509, green: 0.1626217663, blue: 0.2949268222, alpha: 1), textColor: #colorLiteral(red: 0.07895455509, green: 0.1626217663, blue: 0.2949268222, alpha: 1), alignment: .left, borderStyle: .none)
        
        reminderNameTextFiled.delegate = self
    
    }
    func setupTypeButton(){
        typeEntryButton = CustomButton(title: "Entry", fontSize: 12, titleColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), target: self, action: #selector(selectTypeButtonTapped(sender:)), event: .touchUpInside)
        typeEntryButton.tag = 1
        
        typeExitButton =  CustomButton(title: "Exit", fontSize: 12, titleColor: #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1), target: self, action: #selector(selectTypeButtonTapped(sender:)), event: .touchUpInside)
        typeExitButton.tag = 2
        
        typeLabel = CustomLabel(fontSize: 14, text: "Reminder Type: ", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))
        
       
        let buttomStack = CustomStack.init(subview: [typeEntryButton,typeExitButton], alignment: .center, axis: .horizontal, distribution: .fillEqually)
        buttomStack.spacing = 10
        
          buttonStack = CustomStack(subview: [typeLabel,buttomStack], alignment: .fill, axis: .horizontal, distribution: .fill)
        
        typeLabel.widthAnchor.constraint(equalTo: buttonStack.widthAnchor, multiplier: 0.5).isActive = true
   
        typeEntryButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
        typeEntryButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        
        typeExitButton.newLayerColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        typeExitButton.setTitleColor(#colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1), for: .normal)
    
    }
    
    func setUpDateTimeLabel(){
        
        dateTimeLabel = CustomLabel(fontSize: 18, text: "Date and Time", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))

    }
    func  setupDateSelectionPicker(){
        
        dayPickerView = UIPickerView()
        dayPickerView.delegate = self
        dayPickerView.dataSource = self
        
        timeFromPickerView = UIDatePicker()
        timeFromPickerView.datePickerMode = .time
        
        timeToPickerView = UIDatePicker()
        timeToPickerView.datePickerMode = .time
        
        let every = CustomLabel(fontSize: 12, text: "Every", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))
        every.textAlignment = .center
        let from = CustomLabel(fontSize: 12, text: "From", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))
        from.textAlignment = .center
    
        let to = CustomLabel(fontSize: 12, text: "To", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))
        to.textAlignment = .center
        
        let dayPickerStack = CustomStack.init(subview: [every,dayPickerView], alignment: .center, axis: .vertical, distribution: .fillProportionally)
         let timeFromStack = CustomStack.init(subview: [from,timeFromPickerView], alignment: .center, axis: .vertical, distribution: .fillProportionally)
        
         let timeToStack = CustomStack.init(subview: [to,timeToPickerView], alignment: .center, axis: .vertical, distribution: .fillProportionally)
        
        
                pickerStack = CustomStack(subview: [dayPickerStack,timeFromStack,timeToStack], alignment: .center, axis: .horizontal, distribution: .fill)

        
        dayPickerStack.widthAnchor.constraint(equalTo: pickerStack.widthAnchor, multiplier: 0.2).isActive = true
        timeToStack.widthAnchor.constraint(equalTo: pickerStack.widthAnchor, multiplier: 0.4).isActive = true

        timeFromStack.widthAnchor.constraint(equalTo: pickerStack.widthAnchor, multiplier: 0.4).isActive = true
    }
    
    func setupDescriptionTextView(){
        reminderDescriptionTextView = UITextView()
        reminderDescriptionTextView.delegate = self
       // let stack = mainView.subviews.last
        let descriptionLabel = CustomLabel(fontSize: 12, text: "Description", textColor: #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1))
        descriptionStack = CustomStack(subview: [descriptionLabel,reminderDescriptionTextView], alignment: .leading, axis: .vertical, distribution: .fill)
       
        descriptionLabel.heightAnchor.constraint(equalTo: descriptionStack.heightAnchor, multiplier: 0.2).isActive = true
        reminderDescriptionTextView.heightAnchor.constraint(equalTo: descriptionStack.heightAnchor, multiplier: 0.8).isActive = true

         reminderDescriptionTextView.widthAnchor.constraint(equalTo: descriptionStack.widthAnchor, multiplier: 1).isActive = true
        reminderDescriptionTextView.layer.masksToBounds = false
        reminderDescriptionTextView.layer.cornerRadius = 10
        
        reminderDescriptionTextView.text = ""
        reminderDescriptionTextView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 0.09685359589)

    }
    
    func setupDoneButton(){
        saveButton = CustomButton(title: "Save", fontSize: 12, titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), target: self, action: #selector(actionButtonTapped(sender:)), event: .touchUpInside)
        saveButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)

    }
    
    func mainStackAutoLayout(){
        mainStack = CustomStack(subview: [titleLabel,reminderNameTextFiled,buttonStack, dateTimeLabel, pickerStack, descriptionStack, saveButton], alignment: .center, axis: .vertical, distribution: .fill)
        
        mainView.addSubview(mainStack)
        mainStack.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.95).isActive = true
        
        
        mainStack.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.95).isActive = true
        mainStack.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.05).isActive = true
        reminderNameTextFiled.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.05).isActive = true
        buttonStack.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.1).isActive = true
        dateTimeLabel.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.1).isActive = true
        
         pickerStack.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.4).isActive = true
         descriptionStack.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.2).isActive = true
        saveButton.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.08).isActive = true
        saveButton.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.5).isActive = true
        
        buttonStack.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.9).isActive = true
            reminderNameTextFiled.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.9).isActive = true
         dateTimeLabel.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.9).isActive = true
         descriptionStack.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.9).isActive = true
      
    }
    
    @objc func actionButtonTapped(sender: CustomButton){
       
        
        if timeFromPickerView.date > timeToPickerView.date{
            self.presentAlert(title: "Time miss Match", message: "The start time cannot be greater than the end time")
            return
        }
        
        let timeFrom = timeFromPickerView.date.timeToString()
        let timeTo = timeToPickerView.date.timeToString()
        guard let title = reminderNameTextFiled.text else {
            self.presentAlert(title: "No Title", message: "Reminder need a title")
            return
        }
        if title.count < 2{
            self.presentAlert(title: "No Title", message: "Reminder need a title")
            return
        }
        var reminder = Reminder.init(groupId: userGroup.id, id: "", name: title, type: eventType, day: pickedDay, longitude: userGroup.longitude, latitude: userGroup.latitude, timeFrom: timeFrom, timeTo: timeTo)
        guard let desc = reminderDescriptionTextView.text else {
            self.presentAlert(title: "No Description", message: "Reminder need a description")
            return
        }
        if desc.count < 2{
            self.presentAlert(title: "No Description", message: "Reminder need a description")
            return
        }
        
        reminder.description = desc
        
        if userReminder != nil{
            reminder.id = userReminder.id
            ReminderServices.update(reminder)
             self.dismiss(animated: true, completion: nil)
            return
        }
        
        ReminderServices.create(reminder) {
            DispatchQueue.main.async {
                
                 self.dismiss(animated: true, completion: nil)
                
            }
        }
    }
    func addSwipeToDismis() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleMainViewDragged(_:)))
        mainView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handleMainViewDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let translation = gestureRecognizer.translation(in: self.view)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        if gestureRecognizer.state == .ended{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func selectTypeButtonTapped(sender: CustomButton){
        
        switch sender.tag{
        case 1:
            typeEntryButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
            typeEntryButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            
            typeExitButton.newLayerColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            typeExitButton.setTitleColor(#colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1), for: .normal)
            eventType = EventType.onEntry
        case 2:
            typeEntryButton.newLayerColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            typeEntryButton.setTitleColor(#colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1), for: .normal)
            
            typeExitButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
            typeExitButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
             eventType = EventType.onExit
            
        default: break
        }
    }
  
}




/// extension to handle picker view data source
extension NewReminderViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return Constant.days.count
    }
    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       self.pickedDay = Constant.days[row]
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Helvetica", size: 14)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = Constant.days[row]
        pickerLabel?.textColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
        return pickerLabel!
    }
    
}

extension NewReminderViewController: UITextFieldDelegate, UITextViewDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()

            return false
        }
        return true
    }
}
