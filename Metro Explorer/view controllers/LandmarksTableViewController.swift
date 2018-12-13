//
//  LandmarksTableViewController.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/3/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import UIKit
import MBProgressHUD
import CoreLocation

class LandmarksTableViewController: UITableViewController {
    let locationManager = CLLocationManager()
    let locationDetector = LocationDetector()
    let fetchLandmarksManager = FetchLandmarksManager()
    let fetchMetroStationsManager = FetchMetroStationsManager()
    let persistenceManager = PersistenceManager()
    var flag: String = ""
    var metroStation: MetroStation?
    var metroStations = [MetroStation](){
        didSet{
            tableView.reloadData()
        }
    }
    var currentLocation = CLLocation()
    var landmarks = [Landmark]() {
        didSet {
            tableView.reloadData()
        }
    }
    var distances = [Double](){
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        fetchMetroStationsManager.delegate = self
        fetchLandmarksManager.delegate = self
        locationDetector.delegate = self
        
        if flag == "LM"{
            MBProgressHUD.showAdded(to: self.view, animated: true)
            fetchMetroStationsManager.fetchStations()
            
        } else if flag == "S"{
            MBProgressHUD.showAdded(to: self.view, animated: true)
            fetchLandmarksManager.fetchLandmarks(latitude: metroStation!.latitude, longitude: metroStation!.longitude)
        }
        else {
            
            landmarks = PersistenceManager.sharedInstance.fetchLandmarks()
        }
    }
    
    private func fetchLandmarks() {
        //MBProgressHUD.showAdded(to: self.view, animated: true)
        //locationDetector.findLocation()
    }

    //Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //return the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landmarks.count
    }

    //return cell with data from API
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "landmarkCell", for: indexPath) as! LandmarkTableViewCell
            let landmark = landmarks[indexPath.row]
            if let urlString = landmark.imageUrl, let url = URL(string: urlString){
                cell.LandmarkImage.load(url: url)
            }
            cell.LandmarkNameLabel.text = landmark.name
            cell.LandmarkAddressLabel.text = landmark.location.displayAddress.joined(separator: ", ")
        return cell
    }
    //go to LandmarksDetailViewController after select a landmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: "detailSegue", sender: indexPath.row)
    }
    //sending data to LandmarksTableViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row  = sender as! Int
        let vc = segue.destination as! LandmarkDetailViewController
        vc.landmark = landmarks[row]
    }

}

//get latitude and longitude of the landmark
extension LandmarksTableViewController: LocationDetectorDelegate {
    func locationDetected(latitude: Double, longitude: Double) {
        //fetchLandmarksManager.fetchLandmarks(latitude: latitude, longitude: longitude)
        print("location found")
        self.currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        for station in metroStations {
            let stationLocation = CLLocation(latitude: station.latitude, longitude: station.longitude)
            let distance = currentLocation.distance(from: stationLocation)
            distances.append(distance)
        }
        
        if let min = distances.min(){
            let index = distances.firstIndex(of: min)
            metroStation = metroStations[index!]
            fetchLandmarksManager.fetchLandmarks(latitude: metroStation!.latitude, longitude: metroStation!.longitude)
        }
        
        
    }
    
    func locationNotDetected() {
        print("no location found :(")
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

//hide "MBProgressHUD" after loading
//when landmarks not found, show reasons
extension LandmarksTableViewController: FetchLandmarksDelegate{
    func landmarksFound(_ landmarks: [Landmark]) {
        print("lankmarks found")
        DispatchQueue.main.async {
            self.landmarks = landmarks
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func landmarksNotFound(reason: FetchLandmarksManager.FailureReason) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            let alertController = UIAlertController(title: "Problem fetching landmatks", message: reason.rawValue, preferredStyle: .alert)
            switch(reason) {
            case .noResponse:
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                    self.fetchLandmarks()
                })
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler:nil)
                
                alertController.addAction(cancelAction)
                alertController.addAction(retryAction)
                
            case .non200Response, .noData, .badData:
                let okayAction = UIAlertAction(title: "Okay", style: .default, handler:nil)
                
                alertController.addAction(okayAction)
            }
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

//caculate the nearest station to show its landmarks
extension LandmarksTableViewController: FetchStationsDelegate{
    func stationsFound(_ metroStations: [MetroStation]){
        print("stations found")
        DispatchQueue.main.async {
            self.metroStations = metroStations
        }
            locationDetector.findLocation()
        
    }
    func stationsNotFound(reason: FetchMetroStationsManager.FailureReason){
        print("stations not found")
        DispatchQueue.main.async {
            
        }
        
    }
}

