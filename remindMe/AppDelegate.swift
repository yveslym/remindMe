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
    
    class var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        isUserLoggedIn()
        configureUserLocation()
        configureLocalNotification()
        FirebaseApp.configure()
        
        return true
    }
    
    
    /// Method to get authorization from the user for sending push notifications
    fileprivate func configureLocalNotification(){
        
        self.notificationCenter = UNUserNotificationCenter.current()
        notificationCenter?.delegate = self
        let notificationOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter?.requestAuthorization(options: notificationOptions, completionHandler: { (granted, error) in
            if !granted{
                print("Error Found : Permision Not Granted")
            }
        })
    }
    
    /// Method to handle and set up the local notification
    fileprivate func handleEvent(forRegion region: CLRegion!, body: String, title: String){
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder Alert : \(title)"
        content.body = body
        content.sound = UNNotificationSound.default()
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let identifier = region.identifier
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request, withCompletionHandler: { (error) in
            if error != nil {
                print("Error adding notification with identifier: \(identifier)")
            }
        })
    }
    
    
    /// This functions requests the needed access from the user in order to use the user'slocation
    fileprivate func configureUserLocation(){
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        
        // Configuring User Location
        if (CLLocationManager.locationServicesEnabled())
        {
            self.locationManager = CLLocationManager()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestAlwaysAuthorization()
            self.locationManager.startUpdatingLocation()
        }
    }
    
    // This function checks if the user has logged in before on the app to avoid re-showing the login screen
    fileprivate func isUserLoggedIn(){
        
        if UserDefaults.standard.value(forKey: "current") != nil{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            guard let mainVC = storyBoard.instantiateViewController(withIdentifier: "GroupListViewController") as? GroupListViewController else {return}
            let navigation = UINavigationController(rootViewController: mainVC)
            window?.rootViewController = navigation
            window?.makeKeyAndVisible()
        }
    }
    
    /// Method to make the api call to Firebase and retrieve the reminder and group to show on the notification
    fileprivate func prepareForNotification(forRegion region: CLRegion){
        
        let identifier = region.identifier
        ReminderServices.show(identifier) { (reminder) in
            guard let reminder = reminder else {return}
            GroupServices.show(reminder.groupId, completion: { (group) in
                guard let group = group else {return}
                self.handleEvent(forRegion: region, body: reminder.time, title:group.name)
            })
        }
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
    
        if region is CLCircularRegion {
           self.prepareForNotification(forRegion: region)
        }

    }

    /// Function to trigger local notification when the user exits radius of the provided location
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited Region")
        if region is CLCircularRegion{
            self.prepareForNotification(forRegion: region)
        }
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
