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
    var userGroups = [Group](){
        didSet {
            DispatchQueue.main.async {
                self.groupTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.isUnReachable { _ in
            self.showOfflinePage()
        }
    
        groupTableView.delegate = self as UITableViewDelegate
        groupTableView.dataSource = self as UITableViewDataSource
        fetchAllGroups()

    }
    
    // This Method makes a client side request to the server to get all groups
    internal func fetchAllGroups(){
        GroupServices.index(completion: { (groups) in
            self.userGroups = groups!
        })
    }
    
    // This renders the user to an offline page when there is no internet connectivity
    internal func showOfflinePage(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Constant.offlinePageSegueIdentifier, sender: self)
        }
    }
    
    // This method is used to go back to the group of list view controller
    @IBAction func unwindtoGroupListViewController(_ segue: UIStoryboardSegue){
        fetchAllGroups()
    }
}
