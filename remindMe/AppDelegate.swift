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
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let center = UNUserNotificationCenter.current()
    let content = UNMutableNotificationContent()
    var window: UIWindow?
    
    
    class var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
   // lazy var locationManager : CLLocationManager = CLLocationManager()
    var locationManager: CLLocationManager = CLLocationManager()
   
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Configuring Local Notifications
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (didAllow, error) in
            if !didAllow{
                print("They saidd NO boiiiii")
            }else {
                return
            }
        }
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized{
                print("They saii noo boiiiiii :(")
            }else{
                return
            }
        }

        

        // Configuring Firebase
         FirebaseApp.configure()
        
        // Configuring User Location
        if (CLLocationManager.locationServicesEnabled())
        {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        self.locationManager.delegate = self
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }

}

extension AppDelegate: CLLocationManagerDelegate{
    
    
    
    fileprivate func setUpNotificationContent(_ title: String){
        content.title = title
        content.sound = UNNotificationSound.default()
    }
    
    /// Function to trigger local notification when the user enters radius of the provided location
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        let trigerOnEntering = UNLocationNotificationTrigger(region: region, repeats: false)
        let reminderId = region.identifier
        let notificationIdentifier = "notificationOnEntry"
        let notificationRequest = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigerOnEntering)
        
        ReminderServices.show(reminderId) { (reminder) in
            guard let reminder = reminder else {return}
            guard let reminderName = reminder.name else {return}
            
            self.setUpNotificationContent(reminderName)
        }
        
        center.add(notificationRequest) { (error) in
            if let error = error {
                // something went wrong
            }
        }
        
        
    
       
    }
    
    /// Function to trigger local notification when the user exits radius of the provided location
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        let reminderId = region.identifier
     
    }
    
    
    /// Function for when the app starts monitoring
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
    }
    
    /// Function to handle notification when the user has changed the group location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    /// Function for when there has been an error monitoring the user's location
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        
    }
 
    
}
