//
//  GeofireServices.swift
//  remindMe
//
//  Created by Yves Songolo on 1/24/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import Foundation
import GeoFire
import FirebaseDatabase


struct Geofire{

    static var shared = GeoFire()

     func show(){

    }

    func create(group: Group){

        let location = CLLocation.init(latitude: group.latitude, longitude: group.longitude)
        let geofire = Constant.geofireCurrentUser(groupId: group.id)
            geofire.setLocation(location, forKey: group.name)
    }

    func setLocation(location: CLLocation){

        //let geofire = Constant.geofireCurrentUser(groupId:)

        
    }

//    func remove(groupName: String){
//         let geofire = Constant.geofireCurrentUser()
//            geofire.removeKey(groupName)
//    }
}
