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
    /// method to convert address to coordinate
    static func addressToCoordinate(_ address: String, completion: @escaping(CLLocationCoordinate2D?)->()){
        print("getting location coordinate")
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            guard let longitude = lon, let latitutde = lat else {return completion(nil)}
            print("location: lat: \(latitutde) lon: \(longitude)")
            return completion(CLLocationCoordinate2D(latitude: latitutde, longitude: longitude))
        }
    }
    
    /// method to add a single geo fancing within a given region
    static func addNewGeoFencing(region: CLCircularRegion,event: EventType, completion: @escaping(Bool)->()){
        
        switch event{
        case .onEntry:
            region.notifyOnEntry = true
            region.notifyOnExit = false
        case .onExit:
            region.notifyOnEntry = false
            region.notifyOnExit = true
        }
        
       // AppDelegate.shared.locationManager.startMonitoring(for: region)
        startMonitoring(region: region)
        print("start monitoring")
        completion(true)
    }
    private static func startMonitoring(region: CLCircularRegion) {
        // 1
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            //showAlert(withTitle:"Error", message: "Geofencing is not supported on this device!")
            
            return
        }
        // 2
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            //showAlert(withTitle:"Warning", message: "Your geotification is saved but will only be activated once you grant Geotify permission to access the device location.")
        }
        // 3
        let locationManager =  AppDelegate.shared.locationManager
        // 4
        locationManager.startMonitoring(for: region)
    }
    
}

enum EventType: String{
    case onEntry
    case onExit
}



