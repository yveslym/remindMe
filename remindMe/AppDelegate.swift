//
//  AppDelegate.swift
//  remindMe
//
//  Created by Medi Assumani on 9/14/18.
//  Copyright © 2018 Yves Songolo. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation
import JLocationKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    var locationManager: CLLocationManager!
    var notificationCenter: UNUserNotificationCenter!
    //let geofanceRegionCenter = CLLocationCoordinate2DMake(37.7808893, -122.4161106)
    
    
    class var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
   // lazy var locationManager : CLLocationManager = CLLocationManager()
    
   
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        //getting the singleton object and setting iy as its delegate
        self.notificationCenter = UNUserNotificationCenter.current()
        notificationCenter?.delegate = self
        
        // Configuring User Location
        if (CLLocationManager.locationServicesEnabled())
        {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        
        // defining what we need for out notification
        let notificationOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        //requesting perminsion
        notificationCenter?.requestAuthorization(options: notificationOptions, completionHandler: { (granted, error) in
            if !granted{
                print("Error Found : Permision Not Granted")
            }
        })
        
        if launchOptions?[UIApplicationLaunchOptionsKey.location] != nil {
            print("I woke up thanks to geofencing")
        }
        
                // dummy coordinates of vantagio
                let geofenceRegionCenter = CLLocationCoordinate2D(
                    latitude: 37.7808893,
                    longitude: -122.4161106
                )
        

        let geofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 5, identifier: "unique1")
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = true
        
        locationManager.startMonitoring(for: geofenceRegion)
        
        
        // Configuring Firebase
         FirebaseApp.configure()
        
        geofenceRegion.notifyOnEntry = true
        geofenceRegion.notifyOnExit = true

        self.locationManager.startMonitoring(for: geofenceRegion)
        return true
    }
    
    /// method to handle and set up the local notification
    func handleEvent(){
        
        let content = UNMutableNotificationContent()
        content.title = "Hey Medi"
        content.body = "If you're seeing this, you're unblocked!!!"
        content.sound = UNNotificationSound.default()
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        //let identifier = region.identifier
        let identifier = "medi"
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request, withCompletionHandler: { (error) in
            if error != nil {
                print("Error adding notification with identifier: \(identifier)")
            }
        })
    }

    
    
    // - MARK: App cycle methods
    
    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }

}

extension AppDelegate: CLLocationManagerDelegate{
    
    // - MARK: CORE LOCATION METHODS
    
    
    /// Function to trigger local notification when the user enters radius of the provided location
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        print("Entered Location")
//        if region is CLCircularRegion {
//            self.handleEvent(forRegion: region)
//        }

    }

    /// Function to trigger local notification when the user exits radius of the provided location
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//        print("Exited Region")
//        if region is CLCircularRegion{
//            self.handleEvent(forRegion: region)
//        }
    }
    
    
    /// Function for when the app starts monitoring
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("Started Monitoring")
        
    }

    /// Function to handle notification when the user has changed the group location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated")
        self.handleEvent()
    }

    /// Function for when there has been an error monitoring the user's location
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Error : Failed To monitor User Location")
    }

    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // when app is onpen and in foregroud
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // get the notification identifier to respond accordingly
        let identifier = response.notification.request.identifier
        
        // do what you need to do
        print(identifier)
        // ...
    }
}
