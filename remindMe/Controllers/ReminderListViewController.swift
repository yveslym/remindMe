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
    var todayButton: customButton!
    var onEntryButton: customButton!
    var onExitButton:customButton!
    
    var userReminders = [Reminder](){
        didSet{
            DispatchQueue.main.async {
               // self.reminderTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
       self.setUpMainStack()
        self.setupButtonSwitch()
        self.setupTableViewStack()
        self.reminderTableView.reloadData()
    }
    
    func setUpMainStack(){
        mainStack = customStack(frame: view.frame)
        self.view.addSubview(mainStack)
    }
    func setupTableViewStack(){
        
        reminderTableView = UITableView()
        reminderTableView?.separatorStyle = .none
        reminderTableView?.delegate = self
        reminderTableView?.dataSource = self
        reminderTableView.register(ReminderListTableViewCell.self, forCellReuseIdentifier: Constant.reminderTableViewCellIdentifier)
        reminderTableView.backgroundView?.backgroundColor = UIColor.gray
        
        mainStack.addSubview(reminderTableView)
        reminderTableView.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 1)
        reminderTableView.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.6)
       
    }
    func setupButtonSwitch(){
        todayButton = customButton(title: "today", fontSize: 15, titleColor: UIColor.black, target: self, action: #selector(actionButtonTapped(sender:)), event: .touchUpInside)
        
        onExitButton = customButton(title: "Exit", fontSize: 15, titleColor: UIColor.black, target: self, action: #selector(actionButtonTapped(sender:)), event: .touchUpInside)
        
        onEntryButton = customButton(title: "Entry", fontSize: 15, titleColor: UIColor.black, target: self, action: #selector(actionButtonTapped(sender:)), event: .touchUpInside)
        
        todayButton.tag = 1
        todayButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
        onEntryButton.tag = 2
        onExitButton.tag = 3
        
        let stack = customStack(subview: [todayButton,onEntryButton,onExitButton], alignment: .center, axis: .horizontal, distribution: .fillEqually)
        
        self.mainStack.addSubview(stack)
        
        stack.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 1).isActive = true
        stack.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.3).isActive = true
        stack.spacing = 10
    }
    
    @objc func actionButtonTapped(sender: customButton){
        
        switch sender.tag{
        case 1: print(sender.titleLabel?.text)
            
            
            
            case 2: print(sender.titleLabel?.text)
            case 3: print(sender.titleLabel?.text)
        default: return
        }
    }
}
