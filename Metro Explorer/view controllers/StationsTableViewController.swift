//
//  StationsTableViewController.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/3/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import UIKit
import MBProgressHUD

class StationsTableViewController: UITableViewController {
    var flag: String = ""
    let fetchMetroStationsManager = FetchMetroStationsManager()
    var stations = [MetroStation]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMetroStationsManager.delegate = self
        MBProgressHUD.showAdded(to: self.view, animated: true)
        fetchMetroStationsManager.fetchStations()
//        fetchStations()
    
    }
    
    private func fetchStations() {
 //       MBProgressHUD.showAdded(to: self.view, animated: true)
    }

    
    //return the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //return number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    //return cell with data from API
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell", for: indexPath)
        cell.textLabel?.text = stations[indexPath.row].name
        return cell
    }
    //go to LandmarksTableViewController after select a station
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "landmarkSegue", sender: indexPath.row)
    }
    //sending data to LandmarksTableViewController
    //tell the LandmarksTableViewController to show landmarks nearby instead of favorite by using flag
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "landmarkSegue"{
            let vc = segue.destination as! LandmarksTableViewController
            let row  = sender as! Int
            vc.metroStation = stations[row]
            vc.flag = "LM"
        }
    }
    
}

//hide "MBProgressHUD" after loading
//when stations not found, show reasons
extension StationsTableViewController: FetchStationsDelegate {
    func stationsFound(_ metroStations: [MetroStation]) {
        print("stations found")
        DispatchQueue.main.async {
            self.stations = metroStations
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func stationsNotFound(reason: FetchMetroStationsManager.FailureReason) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            let alertController = UIAlertController(title: "Problem fetching stations", message: reason.rawValue, preferredStyle: .alert)
            switch(reason) {
            case .noResponse:
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                    self.fetchStations()
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

