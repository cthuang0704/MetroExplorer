//
//  ViewController.swift
//  Metro Explorer
//
//  Created by hct0704 on 11/18/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import UIKit
import MBProgressHUD


class MenuViewController: UIViewController {
    let fetchLandmarksManager = FetchLandmarksManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //Press the "Nearest" Button to go to LandmarksTableViewController
    @IBAction func NearestButtonPressed(_ sender: Any) {
        print("nearest button pressed")
        performSegue(withIdentifier: "nearestSegue", sender: self)
    }
    //Press the "Select Station" Button to go to StationsTableViewController
    @IBAction func StationButtonPressed(_ sender: Any) {
        print("station button pressed")
        performSegue(withIdentifier: "stationsSegue", sender: self)
    }
    //Press the "Favorite" Button to go to LandmarksTableViewController and display favorite landmarks
    @IBAction func FavoriteButtonPressed(_ sender: Any) {
        print("station button pressed")
        performSegue(withIdentifier: "favoriteResultSegue", sender: self)
    }
    
    //use flag to make distingulish between Nearest landmarks and favorites
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nearestSegue"{
            let vc = segue.destination as! LandmarksTableViewController
            vc.flag = "LM"
        }
        if segue.identifier == "favoriteResultSegue" {
            let vc = segue.destination as! LandmarksTableViewController
            vc.flag = "FAV"
        }
    }
    
}





