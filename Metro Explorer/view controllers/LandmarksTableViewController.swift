//
//  LandmarksTableViewController.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/3/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import UIKit

class LandmarksTableViewController: UITableViewController {
    var metroStation: MetroStation?
    var landmarks = [Landmark]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let fetchLandmarksManager = FetchLandmarksManager()
        fetchLandmarksManager.delegate = self
//        MBProgressHUD.showAdded(to: self.view, animated: true)
        //        locationDetector.delegate = self
        fetchLandmarksManager.fetchLandmarks(latitude: metroStation!.latitude, longitude: metroStation!.longitude)
        
        
    }
    
    private func fetchLandmarks() {
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
        return landmarks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "landmarkCell", for: indexPath)

        let landmark = landmarks[indexPath.row]
        cell.textLabel?.text =  landmark.name
        return cell
    }

}

extension LandmarksTableViewController: FetchLandmarksDelegate{
    func landmarksFound(_ landmarks: [Landmark]) {
        print("lankmarks found")
        DispatchQueue.main.async {
            self.landmarks = landmarks
//            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func landmarksNotFound(reason: FetchLandmarksManager.FailureReason) {
        DispatchQueue.main.async {
//            MBProgressHUD.hide(for: self.view, animated: true)
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
