//
//  LocationDetector.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/3/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationDetectorDelegate{
    func locationDetected(latitude: Double, longitude: Double)
    func locationNotDetected()//for no signal or no permission or time out
    
}

//things todo: handle timeout, write code yourself

class LocationDetector: NSObject{
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    func findLocation(){
       // let permissionStatus = CLLocationManagerDelegate.authorizationStatus()
    
    
    }
    
}

extension LocationDetector: CLLocationManagerDelegate{
    
    
}
