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
   //     locationManager.delegate = self
        
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
    @IBAction func FavoriteButtonPressed(_ sender: Any) {
        print("station button pressed")
        performSegue(withIdentifier: "favoriteResultSegue", sender: self)
    }
    
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





