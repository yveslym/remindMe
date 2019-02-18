//
//  GroupListViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/18/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//


import Foundation
import UIKit
import CoreLocation
import SquareRegion
import Reachability
import UIEmptyState

protocol GroupDelegate: class {
    func didRescievedNewNotification(reminder: Reminder)
}

class GroupListViewController: UIViewController, UIEmptyStateDelegate, UIEmptyStateDataSource{
// This View Controller class handles functionality to show the list of all the groups

    // - MARK: Class Properties

    var emptyImage = UIImage(named: "empty")
    var emptyStateTitle: NSAttributedString {
        let attrs = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.882, green: 0.890, blue: 0.859, alpha: 1.00),
                     NSAttributedString.Key.font: UIFont.systemFont(ofSize: 27)]
        return NSAttributedString(string: "No Groups Created. Tap + to add a group.", attributes: attrs)
    }
    var groupListTableView =  UITableView()
    var remindersDataStackView = UIStackView()
    var totalRemindersStackView = UIStackView()
    var totalRemindersOnEntryStackView = UIStackView()
    var totalRemindersOnExitStackView = UIStackView()
    var tableViewStackView = UIStackView()
    var totalRemindersBox = UIView()
    var totalRemindersOnEntryBox =  UIView()
    var totalRemindersOnExitBox = UIView()
    var totalReminderAmountLabel = UILabel()
    var totalReminderTextView = UITextView()
    var totalRemindersOnEntryAmountLable = UILabel()
    var totalRemindersOnEntryTextView = UITextView()
    var totalRemindersOnExitAmountLable = UILabel()
    var totalRemindersOnExitTextView = UITextView()
    var squareRegionDelegate = AppDelegate.shared.squareRegionDelegate
    let networkManager = NetworkManager.shared
    var locationManager = AppDelegate.shared.locationManager
    var reminders = [Reminder]()
    let network = NetworkManager.shared
    var userGroups = [Group](){
        didSet {
            DispatchQueue.global().async {
                ReminderServices.index(completion: { (reminders) in
                    if let reminders = reminders{
                        self.userReminders = reminders
                    }
                    else{
                        DispatchQueue.main.async {
                            self.groupListTableView.reloadData()
                            self.reloadEmptyStateForTableView(self.groupListTableView)
                        }
                    }
                })
            }
        }
    }
    var userReminders = [Reminder](){
        didSet{
            DispatchQueue.main.async {
                self.groupListTableView.reloadData()
                self.reloadEmptyStateForTableView(self.groupListTableView)
            }
        }
    }
    
    // - MARK: VIEW CONTROLLER LIFE CYCLE METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.emptyStateDataSource = self
        self.emptyStateDelegate = self
        self.groupListTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        self.reloadEmptyStateForTableView(groupListTableView)
        configureUserLocation()
        setUpNavigationBarItems()
        fetchAllGroups()
        addViews()
        monitorReminders()
        obserUpdatedGroup()
        observeAddedGroup()
        observeRemovedGroup()
        networkManager.reachability.whenUnreachable = { reachability in
            self.showOfflinePage()
        }
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reloadEmptyStateForTableView(groupListTableView)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        createRectangularViews()
        createCustomRemindersLabels()
        anchorTableView()
        anchorTableViewTitle()
        anchorRemindersDataContainer()
        anchorTableViewContainer()
        anchorRemindersDataStackView()
        anchorTotalRemindersStackView()
        anchorEntriesReminderStackView()
        anchorExitReminderStackView()
        updateReminderLabels()
    }
    
    
    /// This functions requests the needed access from the user in order to use the user'slocation
    fileprivate func configureUserLocation(){
        
        self.locationManager = CLLocationManager()
        
        // Configuring User Location
        if (CLLocationManager.locationServicesEnabled())
        {
            self.locationManager = CLLocationManager()
            self.locationManager?.delegate = self
            self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager?.requestAlwaysAuthorization()
            self.locationManager?.startUpdatingLocation()
            self.locationManager?.allowsBackgroundLocationUpdates = true
        }
    }
    
    
    /// Pushes a view controller that tells the user that he/she is offline
    fileprivate func showOfflinePage(){
        DispatchQueue.main.async {
            let destinationVc = OfflineViewController()
            self.navigationController?.pushViewController(destinationVc, animated: true)
        }
    }
    
    /// Makes api call and get all teh groups created by the user
    internal func fetchAllGroups(){
        GroupServices.index(completion: { (groups) in
            if let groups = groups{
                self.userGroups = groups
            }
        })
    }
    
    /// Updates all the reminders labels with proper numbers
    func updateReminderLabels(){

        var entryCounter = 0
        var exitCounter = 0
        var totalRemindersCountter = 0
        ReminderServices.index { (reminders) in
            guard let reminders = reminders else {return}
            
            reminders.forEach({ (reminder) in
                if reminder.type?.rawValue == "Entry" || reminder.type?.rawValue == "entry"{
                    entryCounter += 1
                    totalRemindersCountter += 1
                }else if  reminder.type?.rawValue == "Exit" || reminder.type?.rawValue == "exit"{
                    exitCounter += 1
                    totalRemindersCountter += 1
                }
            })
            
            DispatchQueue.main.async {
                self.totalRemindersOnEntryAmountLable.text = entryCounter.convertIntToString()
                self.totalRemindersOnExitAmountLable.text = exitCounter.convertIntToString()
                self.totalReminderAmountLabel.text = reminders.count.convertIntToString()
            }
        }
    }
    
    
    /// Triggers the Geofence API to start monitoring the groups' addresses
    fileprivate func monitorReminders(){
        squareRegionDelegate = self
        ReminderServices.index { (reminders) in

            guard let reminders = reminders else {return}
            self.reminders = reminders
            GeoFence.shared.startMonitor(reminders, squareRegionDelegate: self.squareRegionDelegate, completion: { (_) in
                print("start monitoring")
            })
        }
    }
    
    /// Sets up home page title and nav bar items
    fileprivate func setUpNavigationBarItems(){

        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))

        // Styling the home page title
        titleLabel.text = "Dashboard"
        titleLabel.textColor = .gray
        titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .white
        titleLabel.adjustsFontSizeToFitWidth = true
        
        // Styling the home page navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGroupButtonTapped))
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.alpha = 0.0
    }
    
    /// Shows the user a page to create a group
    @objc fileprivate func addGroupButtonTapped(){

        let destination = CreateGroupViewController()
        destination.modalPresentationStyle = .overCurrentContext
        destination.modalTransitionStyle = .crossDissolve
        self.present(destination, animated: true, completion: nil)
    }
    
    fileprivate func observeAddedGroup(){
        GroupServices.observeAddedGroup { (group) in
            self.userGroups.append(group)
        }
    }
    
    fileprivate func observeRemovedGroup(){
        GroupServices.observeDeletedGroup { (groups) in
            self.userGroups = groups ?? [Group]()
        }
    }
    
    fileprivate func obserUpdatedGroup(){
        GroupServices.observeUpdatedGroup { (groups) in
            self.userGroups = groups ?? [Group]()
        }
    }
    
    // - MARK: UI ELEMENTS AND METHODS
    
    let remindersContainer: UIView = {
        
        let view = UIView()
        view.backgroundColor = .lightCyan
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.shadowRadius = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    let tableViewContainer: UIView = {
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.shadowRadius = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
  
    let tableViewTitle: UILabel = {
    
        let label = UILabel()
        label.text = "My Groups"
        label.textColor = .gray
        label.font = UIFont(name: "HelveticaNeue-Light", size: 18)
        return label
    }()
}

extension GroupListViewController: RegionProtocol, CLLocationManagerDelegate{
    func didEnterRegion(region: CKSquareRegion) {

        let reminder = self.reminders.filter({$0.id == region.identifier}).first
         print("enter to reminder \(reminder?.name ?? "")")

        // checks if the user is re-connected after entering the region
       // network.reachability.whenReachable = { reachability in
            AppDelegate.shared.prepareForNotification(forRegion: region, reminder: reminder)
        //}
    }

    func didExitRegion(region: CKSquareRegion) {

        let reminder = self.reminders.filter({$0.id == region.identifier}).first
        print("leave to reminder \(reminder?.name ?? "")")
        // checks if the user is re-connected after entering the region
       // network.reachability.whenReachable = { reachability in
            AppDelegate.shared.prepareForNotification(forRegion: region, reminder: reminder)
        //}
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            squareRegionDelegate?.updateRegion(location: location)
        }
    }


}
