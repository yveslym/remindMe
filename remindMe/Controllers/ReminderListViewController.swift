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
//        let topview = UIView()
//        mainStack.addArrangedSubview(topview)
//        topview.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.6).isActive = true
        //reminderTableView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 0.2668289812)
        
        
        mainStack.addArrangedSubview(reminderTableView)
        reminderTableView.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 0.9).isActive = true
        reminderTableView.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.8).isActive = true
       reminderTableView.leftAnchor.constraint(equalTo: mainStack.leftAnchor, constant: 20).isActive = true
          reminderTableView.rightAnchor.constraint(equalTo: mainStack.rightAnchor, constant: -40).isActive = true
         reminderTableView.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 20).isActive = true
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
