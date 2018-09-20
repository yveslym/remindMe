//
//  ViewController.swift
//  remindMe
//
//  Created by Yves Songolo on 9/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = AppDelegate.shared.locationManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
     let address = "555 post st, San Francisco, CA"
        GeoFence.addressToCoordinate(address) { (location) in
            if let location = location{
                
                let region = CLCircularRegion(center: location, radius: 5, identifier: "new location")
                GeoFence.addNewGeoFencing(region: region, event: .onEntry, completion: { (entry) in
                    if entry == true{
                         self.view.backgroundColor = UIColor.blue
                    }
                })
            }
            else{
                self.view.backgroundColor = UIColor.brown
            }
           
        }
       locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        self.view.backgroundColor = UIColor.green
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
         self.view.backgroundColor = UIColor.yellow
    }
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        self.view.backgroundColor = UIColor.darkGray
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            //self.locationManager.location = location
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

