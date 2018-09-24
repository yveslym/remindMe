//
//  ViewController.swift
//  remindMe
//
//  Created by Yves Songolo on 9/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import CoreLocation
import JLocationKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager :  CLLocationManager!
    var locationList: [JLocation] = []
    var map = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManager = CLLocationManager()
        if (CLLocationManager.locationServicesEnabled())
        {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        
        let address = "1368 natoma st, San Francisco, CA"
        GeoFence.addressToCoordinate(address) { (location) in
            if let location = location{
                let lat = location.latitude
                let lon = location.longitude
                let item = JLocation(latitude: lat, longitude: lon, radius: 50, identifier: "youpppiiii")
                
                self.locationList.append(item)
                
              let region = CLCircularRegion(center: location, radius: 50, identifier: "yesss")
                GeoFence.addNewGeoFencing(locationManager: self.locationManager, region: region, event: .onExit, completion: { (cool) in
                    print(cool)
                })
//                self.map = MKMapView(frame: self.view.frame)
//                let annotation = MKPointAnnotation()
//                annotation.title = "home"
//                annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
//                self.map.addAnnotation(annotation)
//                self.view.addSubview(self.map)
                
            }
        }
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
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            //let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            //self.map.setRegion(region, animated: true)
        }
    }
}

