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
    
        groupTableView.delegate = self as UITableViewDelegate
        groupTableView.dataSource = self as UITableViewDataSource
        fetchAllGroups()

    }
    
    // THIS FUNCTION MAKES AN API CALL TO GET ALL GROUPS FROM THE CLIENT SIDE
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
