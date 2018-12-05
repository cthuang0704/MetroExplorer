//
//  StationsTableViewController.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/3/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import UIKit

class StationsTableViewController: UITableViewController {

    var stations = [MetroStation]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchMetroStationsManager = FetchMetroStationsManager()
        fetchMetroStationsManager.delegate = self

//        MBProgressHUD.showAdded(to: self.view, animated: true)
        fetchMetroStationsManager.fetchStations()
    
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

    
}
extension StationsTableViewController: FetchStationsDelegate {
    func stationsFound(_ metroStations: [MetroStation]) {
        print("stations found - here they are in the controller!")
        DispatchQueue.main.async {
            self.stations = metroStations
//            MBProgressHUD.hide(for: self.view, animated: true)
    }
    }
    
    func stationsNotFound() {
        print("no stations found")
        
        DispatchQueue.main.async {
            //MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
}

