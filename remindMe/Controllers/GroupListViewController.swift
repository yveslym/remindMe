//
//  GroupListViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/18/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//


import Foundation
import UIKit

class GroupListViewController: UIViewController{
// This View Controller class handles functionality to show the list of all the groups


    @IBOutlet weak var groupTableView: UITableView!
    static var numberOfReminders = 0
    let networkManager = NetworkManager.shared
    var userGroups = [Group](){
        didSet {
            DispatchQueue.main.async {
                self.groupTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupTableView.delegate = self as UITableViewDelegate
        groupTableView.dataSource = self as UITableViewDataSource
        fetchAllGroups()
        
        networkManager.reachability.whenUnreachable = { reachability in
            self.showOfflinePage()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.groupTableView.reloadData()
        }
    }
    
    
    fileprivate func showOfflinePage(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Constant.offlinePageSegueIdentifier, sender: self)
        }
    }
    // This Method makes a client side request to the server to get all groups
    internal func fetchAllGroups(){
        GroupServices.index(completion: { (groups) in
            self.userGroups = groups!
        })
    }
    
    fileprivate func monitorReminders(){
        ReminderServices.index { (reminders) in
            guard let reminders = reminders else {return}
            GeoFence.shared.startMonitor(reminders, completion: { (true) in
                print("Start Monitoring")
            })
        }
    }
    
    // This method is used to go back to the group of list view controller
    @IBAction func unwindtoGroupListViewController(_ segue: UIStoryboardSegue){
        fetchAllGroups()
    }
}
