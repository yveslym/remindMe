////
////  remindMeTests.swift
////  remindMeTests
////
////  Created by Yves Songolo on 9/14/18.
////  Copyright © 2018 Yves Songolo. All rights reserved.
////
//
//import XCTest
//@testable import remindMe
//import CoreLocation
//
//class remindMeTests: XCTestCase, CLLocationManagerDelegate {
//
//    //MARK: - Location Manager Delegate
//    var userTest: User!
//    var groupTest: Group!
//     let manager = CLLocationManager()
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        
//        groupTest = Group(id: "1234", name: "home", latitude: 37.773972, longitude: -122.431297)
//        
//        manager.delegate = self
//        
//
//    }
//    
//    func testLoginUser(){
//        // given
//        UserServices.signIn("test@test.com", "123456") { (user) in
//            //when
//            let user = user as! User
//            
//            //then
//            XCTAssertTrue(user.email == "test@test.com")
//            self.userTest = user
//        }
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//        groupTest = nil
//    }
//    func testAddGroupGeofenceStartMonitor(){
//        // given
//    
//        let reminder = Reminder(name: "feed fish", type: .onEntry, time: "12:00")
//        let reminder2 = Reminder(name: "feed bird", type: .onEntry, time: "12:00")
//        let reminder3 = Reminder(name: "feed cat", type: .onEntry, time: "12:00")
//        groupTest.reminders.append(reminder)
//        groupTest.reminders.append(reminder2)
//        groupTest.reminders.append(reminder3)
//        var groupArray = [Group]()
//        groupArray.append(groupTest)
//        
//        
//        // when
//        GeoFence.shared.startMonitor(groupArray) { (added) in
//            // then
//            XCTAssertTrue(added == true, "all added")
//            XCTAssertTrue(self.manager.monitoredRegions.count == 3, "all works")
//        }
//    }
//    func testRegionMonitoring(){
//        // given
//        let cat = manager.monitoredRegions.filter({$0.identifier == "feed cat"})
//        let fish = manager.monitoredRegions.filter({$0.identifier == "feed fish"})
//        let bird = manager.monitoredRegions.filter({$0.identifier == "feed bird"})
//        
//        XCTAssertTrue(cat.count == 1, "there's cat")
//        XCTAssertTrue(fish.count == 1, "there's fish")
//        XCTAssertTrue(bird.count == 1, "there's bird")
//        
//    }
//    
//    func testPostGroup(){
//        // given
//        var group = Group(id: "", name: "home", latitude: 37.773972, longitude: -122.431297)
//        let reminder = Reminder(name: "feed fish", type: .onEntry, time: "12:00")
//        group.reminders.append(reminder)
//        GroupServices.create(group) { (group) in
//            XCTAssertTrue(group.reminders.count == 1)
//        }
//    }
//    
//    func testAddReminder(){
//        // 1. given
//        let reminder = Reminder(name: "feed cat", type: .onEntry, time: "12:00")
//        
//        // 2. when
//        groupTest.reminders.append(reminder)
//        
//        //3. then
//        XCTAssertTrue(groupTest.reminders.count == 1, "1 reminder was add")
//    }
//    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//    
//}
