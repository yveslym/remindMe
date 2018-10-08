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

// This View Controllers is for showing the list of all the groups
class GroupListViewController: UIViewController{
    
    // - MARK : IBOULETS AND VARIABLES
    @IBOutlet weak var groupTableView: UITableView!
    
    static var numberOfReminders = 0
    let locationManager = CLLocationManager()
    var userGroups = [Group](){
        didSet {
            DispatchQueue.main.async {
                self.groupTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dummy coordinates of vantagio
        let geofenceRegionCenter = CLLocationCoordinate2D(
            latitude: 37.7808893,
            longitude: -122.4161106
        )
        
        
        let geofenceRegion = CLCircularRegion(
            center: geofenceRegionCenter,
            radius: 5,
            identifier: "unique1")
        
        
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = true
        
        self.locationManager.startMonitoring(for: geofenceRegion)
        
        
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
