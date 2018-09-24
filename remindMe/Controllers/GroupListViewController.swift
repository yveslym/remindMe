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
    
    
    // The array that contains the list of all of the user's groups
    var userGroups = [Group](){
        didSet {
        groupTableView.reloadData()
        }
    }
    
    var dummyArray: [String] = ["Home", "Work", "Lake House", "Studio"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupTableView.delegate = self as UITableViewDelegate
        groupTableView.dataSource = self as UITableViewDataSource
        
    }
    
    // Function to unwind segues for navigation
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue){
        // empty for now
    }
    

}
