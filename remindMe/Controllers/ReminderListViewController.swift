//
//  ReminderListViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/20/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import SquareRegion
import UIEmptyState
import UIKit

class ReminderListViewController: UIViewController, UIEmptyStateDataSource, UIEmptyStateDelegate{
    // This View Controller class handles functionality to show the list of all the reminders
    
    var emptyStateTitle: NSAttributedString {
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.882, green: 0.890, blue: 0.859, alpha: 1.00),
                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)]
        return NSAttributedString(string: "No Reminders Created. Tap + to add a reminder.", attributes: attrs)
    }
    var reminderTableView = UITableView()
    var mainStack: UIStackView!
    var todayButton: CustomButton!
    var onEntryButton: CustomButton!
    var onExitButton:CustomButton!
    var userGroup: Group!
    var sortedReminder = [Reminder](){
        didSet{
            DispatchQueue.main.async {
                self.reminderTableView.reloadData()
                self.reloadEmptyStateForTableView(self.reminderTableView)
            }
        }
    }
    
    var userReminders = [Reminder](){
        didSet{
            sortedReminder = userReminders
        }
    }
    
    
    // - MARK: VIEW CONTROLLER LIFE CYCLE METHODS
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllReminder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        // Setting up Empty Table view of reminders
        self.setupButtonSwitch()
        self.emptyStateDataSource = self
        self.emptyStateDelegate = self
        self.reminderTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.reloadEmptyStateForTableView(reminderTableView)
        
//        self.setupButtonSwitch()
        self.reminderTableView.reloadData()
        setUpNavigationBarItems()
        observeEntryReminder()
        obserUpdatedReminder()
        observeRemovedReminder()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadEmptyStateForTableView(reminderTableView)
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
   
    func setupButtonSwitch(){
        todayButton = CustomButton(title: "All", fontSize: 18, titleColor: UIColor.black, target: self, action: #selector(actionButtonTapped(sender:)), event: .touchUpInside)
        
        onExitButton = CustomButton(title: "Exit", fontSize: 18, titleColor: UIColor.black, target: self, action: #selector(actionButtonTapped(sender:)), event: .touchUpInside)
        
        onEntryButton = CustomButton(title: "Entry", fontSize: 18, titleColor: UIColor.black, target: self, action: #selector(actionButtonTapped(sender:)), event: .touchUpInside)
        
        todayButton.tag = 1
        todayButton.newLayerColor = #colorLiteral(red: 0.1803921569, green: 0.368627451, blue: 0.6666666667, alpha: 1)
        onEntryButton.tag = 2
        onExitButton.tag = 3
        
        let stack = CustomStack(subview: [todayButton,onEntryButton,onExitButton], alignment: .center, axis: .horizontal, distribution: .fillEqually)
        
        reminderTableView = UITableView()
        reminderTableView.separatorStyle = .none
        
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
        reminderTableView.register(ReminderListTableViewCell.self, forCellReuseIdentifier: Constant.reminderTableViewCellIdentifier)

        
       mainStack = CustomStack.init(subview: [stack,reminderTableView], alignment: .center, axis: .vertical, distribution: .fill)
        
        stack.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 1).isActive = true
        stack.heightAnchor.constraint(equalTo: mainStack.heightAnchor, multiplier: 0.1).isActive = true
        
        reminderTableView.widthAnchor.constraint(equalTo: mainStack.widthAnchor, multiplier: 1).isActive = true
        stack.spacing = 10
        
        self.view.addSubview(mainStack)
        mainStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 10,
                         paddingLeft: 10,
                         paddingBottom: 10,
                         paddingRight: 10,
                         width: 0,
                         height: 0,
                         enableInsets: true)
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
        titleLabel.text = userGroup.name + " Reminders"
        titleLabel.textColor = .gray
        titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .clear
        titleLabel.adjustsFontSizeToFitWidth = true
        
        // Styling the home page navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addReminderButtonTapped))
        navigationItem.titleView = titleLabel

    }
    
    /// Show the view controller to create a reminder
    @objc fileprivate func addReminderButtonTapped(){
        
        let destination = NewReminderViewController()
        destination.modalPresentationStyle = .overCurrentContext
        destination.modalTransitionStyle = .crossDissolve
        destination.userGroup = userGroup
       
        self.present(destination, animated: true, completion: nil)
    }
    
    /// Add a created reminder on the list to be monitored
    func observeEntryReminder(){
        ReminderServices.observeAddedReminder { (reminder) in
            self.userReminders.append(reminder)
            let region = CKSquareRegion.init(regionWithCenter: CLLocationCoordinate2D.init(latitude: reminder.latitude, longitude: reminder.longitude), sideLength: 0.045, identifier: reminder.id)
            AppDelegate.shared.squareRegionDelegate.addRegionToMonitor(region: region!)
            

        }
    }
    
    /// Monitor a reminder that has been deleted
    func observeRemovedReminder(){
        ReminderServices.observeRemovedReminder { (reminders) in
            self.userReminders = reminders ?? [Reminder]()
           
        }
    }
    
    /// Monitor a reminder that has been updated
    func obserUpdatedReminder(){
        ReminderServices.observeUpdatedReminder { (reminders) in
            self.userReminders = reminders!
        }
    }
   
}
