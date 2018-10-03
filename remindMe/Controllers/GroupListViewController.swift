//
//  GroupListViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/18/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//


import Foundation
import UIKit

// This View Controllers is for showing the list of all the groups
class GroupListViewController: UIViewController{
    
    // - MARK : IBOULETS AND VARIABLES
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
        
        // SETTING UP THE GROUPS TABLE VIEW
        groupTableView.delegate = self as UITableViewDelegate
        groupTableView.dataSource = self as UITableViewDataSource
        UserServices.signIn("test@test.com", "123456") { (user) in
            self.fetchAllGroups()
        }
        
    }
    
    
    // THIS FUNCTION MAKES AN API CALL TO GET ALL GROUPS
    internal func fetchAllGroups(){
        GroupServices.index(completion: { (groups) in
            self.userGroups = groups!
        })
    }
    
    // THIS METHOD IS USED FOR UNWINDING SEGUE
    @IBAction func unwindtoGroupListViewController(_ segue: UIStoryboardSegue){
        fetchAllGroups()
    }
}
