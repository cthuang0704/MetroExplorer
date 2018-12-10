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
    
//    let locationDetector = LocationDetector()
    var stations = [MetroStation]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchMetroStationsManager = FetchMetroStationsManager()
        fetchMetroStationsManager.delegate = self
         MBProgressHUD.showAdded(to: self.view, animated: true)
//        locationDetector.delegate = self
        fetchMetroStationsManager.fetchStations()
    
    }
    
    private func fetchStations() {
        //MBProgressHUD.showAdded(to: self.view, animated: true)
//        locationDetector.findLocation()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell", for: indexPath)
        cell.textLabel?.text = stations[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "landmarkSegue", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row  = sender as! Int
        
        let vc = segue.destination as! LandmarksTableViewController
        vc.metroStation = stations[row]
    }
    
}
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

