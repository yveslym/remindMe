//
//  ReminderListViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/20/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import UIKit

class ReminderListViewController: UIViewController{
    // This View Controller class handles functionality to show the list of all the reminders
    var reminderTableView: UITableView!
    var mainStack: UIStackView!
    var todayButton: CustomButton!
    var onEntryButton: CustomButton!
    var onExitButton:CustomButton!
    var userGroup: Group!
    var sortedReminder = [Reminder](){
        didSet{
            DispatchQueue.main.async {
                 self.reminderTableView.reloadData()
                
            }
        }
    }
    
    var userReminders = [Reminder](){
        didSet{
            sortedReminder = userReminders
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllReminder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
       self.setUpMainStack()
        self.setupButtonSwitch()
        self.setupTableViewStack()
        self.reminderTableView.reloadData()
     setUpNavigationBarItems()
        observeEntryReminder()
    }
    
    func fetchAllReminder(){
        ReminderServices.indexByGroupId(groupId: userGroup.id) { (reminders) in
            if let reminders = reminders{
                self.userReminders = reminders
            }
        }
    }
    func setUpMainStack(){
        mainStack = CustomStack(frame: view.frame)
        self.view.addSubview(mainStack)
       
    }
    func setupTableViewStack(){
        
        reminderTableView = UITableView()
        reminderTableView?.separatorStyle = .none
        reminderTableView?.delegate = self
        reminderTableView?.dataSource = self
        reminderTableView.register(ReminderListTableViewCell.self, forCellReuseIdentifier: Constant.reminderTableViewCellIdentifier)

        mainStack.addArrangedSubview(reminderTableView)
        reminderTableView.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.9).isActive = true
        reminderTableView.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.8).isActive = true
       reminderTableView.leftAnchor.constraint(equalTo: mainStack.leftAnchor, constant: 20).isActive = true
          reminderTableView.rightAnchor.constraint(equalTo: mainStack.rightAnchor, constant: -40).isActive = true
         reminderTableView.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 20).isActive = true
    }
    func setupButtonSwitch(){
        todayButton = CustomButton(title: "today", fontSize: 15, titleColor: UIColor.black, target: self, action: #selector(actionButtonTapped(sender:)), event: .touchUpInside)
        
        onExitButton = CustomButton(title: "Exit", fontSize: 15, titleColor: UIColor.black, target: self, action: #selector(actionButtonTapped(sender:)), event: .touchUpInside)
        
        onEntryButton = CustomButton(title: "Entry", fontSize: 15, titleColor: UIColor.black, target: self, action: #selector(actionButtonTapped(sender:)), event: .touchUpInside)
        
        todayButton.tag = 1
        todayButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
        onEntryButton.tag = 2
        onExitButton.tag = 3
        
        let stack = CustomStack(subview: [todayButton,onEntryButton,onExitButton], alignment: .center, axis: .horizontal, distribution: .fillEqually)
        
        self.mainStack.addSubview(stack)
        
        stack.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.9).isActive = true
        stack.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.3).isActive = true
       stack.leftAnchor.constraint(equalTo: mainStack.leftAnchor, constant: 20).isActive = true
        stack.spacing = 10
    }
    
    @objc func actionButtonTapped(sender: CustomButton){
        
        switch sender.tag{
        case 1:
            todayButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
             onExitButton.newLayerColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
             onEntryButton.newLayerColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            sortedReminder = userReminders
            case 2:
                sortedReminder = []
                todayButton.newLayerColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                onExitButton.newLayerColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                onEntryButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
            sortedReminder = userReminders.filter({$0.type == EventType.onEntry})
            case 3:
                sortedReminder = []
                todayButton.newLayerColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                onExitButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
                onEntryButton.newLayerColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
             sortedReminder = userReminders.filter({$0.type == EventType.onExit})
        default: return
        }
    }
    /// Sets up home page title and nav bar items
    fileprivate func setUpNavigationBarItems(){
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        
        // Styling the home page title
        titleLabel.text = userGroup.name
        titleLabel.textColor = .gray
        titleLabel.font = UIFont(name: "Rockwell", size: 20)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        titleLabel.adjustsFontSizeToFitWidth = true
        
        // Styling the home page navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGroupButtonTapped))
        navigationItem.titleView = titleLabel

    }
    
    ///
    @objc fileprivate func addGroupButtonTapped(){
        
        let destination = NewReminderViewController()
        destination.modalPresentationStyle = .overCurrentContext
        destination.modalTransitionStyle = .crossDissolve
        destination.userGroup = userGroup
       
        self.present(destination, animated: true, completion: nil)
    }
    func observeEntryReminder(){
        ReminderServices.observeEntryReminder { (reminder) in
            self.userReminders.append(reminder)
            }
    }
   
}
