//
//  ViewController.swift
//  Metro Explorer
//
//  Created by hct0704 on 11/18/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import UIKit
import CoreLocation

class MenuViewController: UIViewController {
    let fetchLandmarksManager = FetchLandmarksManager()
    let locationManager = CLLocationManager()
    let locationDetector = LocationDetector()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   //     locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func NearestButtonPressed(_ sender: Any) {
        print("nearest button pressed")
        //locationDetector.delegate = self
        performSegue(withIdentifier: "nearestSegue", sender: self)
        
    }
    
    @IBAction func StationButtonPressed(_ sender: Any) {
        print("station button pressed")
        performSegue(withIdentifier: "stationsSegue", sender: self)
    }
}

//extension LandmarksTableViewController: LocationDetectorDelegate{
//    func locationDetected(latitude: Double, longitude: Double) {
//        
//    }
//    func locationNotDetected() {
//        <#code#>
//    }
//}

/*
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lat = locations.last?.coordinate.latitude, let long = locations.last?.coordinate.longitude {
            print("\(lat),\(long)")
        } else {
            print("No coordinates")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
 */
