//
//  GeoCoder.swift
//  remindMe
//
//  Created by Yves Songolo on 9/18/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import Foundation
import CoreLocation

struct GeoFence{
    
    static let shared = GeoFence()
    private let locationManager = AppDelegate.shared.locationManager

    /// Method to convert address to coordinate
    func addressToCoordinate(_ address: String, completion: @escaping(CLLocationCoordinate2D?)->()){
        print("getting location coordinate")
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            
            if error != nil {return completion(nil)}
            
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            guard let longitude = lon, let latitutde = lat else {return completion(nil)}
            print("location: lat: \(latitutde) lon: \(longitude)")
            
            return completion(CLLocationCoordinate2D(latitude: latitutde, longitude: longitude))
            
        }
    }
    
    /// Method to add a single geo fancing within a given region
    private func addNewGeoFencing(locationManager: CLLocationManager, region: CLCircularRegion,event: EventType){
        
        switch event{
        case .onEntry:
            region.notifyOnEntry = true
            region.notifyOnExit = false
        case .onExit:
            region.notifyOnEntry = false
            region.notifyOnExit = true
        }

        self.locationManager?.startMonitoring(for: region)
        print("start monitoring")
        
    }
    
    /// Method to start monitoring
    func startMonitor(_ reminders: [Reminder], completion: @escaping(Bool)->()){
        let dg = DispatchGroup()
        reminders.forEach({
            dg.enter()
            let center = CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude)
            let region = CLCircularRegion.init(center: center, radius: 20, identifier: $0.id)
            let manager = CLLocationManager()
            addNewGeoFencing(locationManager: manager, region: region, event: $0.type!)
            dg.leave()
        })
        dg.notify(queue: .global()) {
            completion(true)
        }
    }
}
