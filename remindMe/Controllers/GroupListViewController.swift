//
//  GroupListViewController.swift
//  remindMe
//
//  Created by Medi Assumani on 9/18/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//


import Foundation
import UIKit

// This VC is to show the list of all the groups
class GroupListViewController: UIViewController{
    
    // - MARK : IBOULETS AND VARIABLES
    @IBOutlet weak var groupTableView: UITableView!
    
    var userGroups = [Group](){
        didSet {
            groupTableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupTableView.delegate = self as UITableViewDelegate
        groupTableView.dataSource = self as UITableViewDataSource
        
    }
    
    // Function to unwind segues for navigation
    @IBAction func unwindtoGroupListViewController(_ segue: UIStoryboardSegue){
        // empty for now
    }
    

}
