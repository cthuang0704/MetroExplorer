//
//  ViewController.swift
//  Metro Explorer
//
//  Created by hct0704 on 11/18/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func NearestButtonPressed(_ sender: Any) {
        print("nearest button pressed")
        performSegue(withIdentifier: "nearestSegue", sender: self)
        
    }
    
    @IBAction func StationButtonPressed(_ sender: Any) {
        print("station button pressed")
        performSegue(withIdentifier: "stationsSegue", sender: self)
    }
    
    
   /*
    @IBAction func selectStationButPressed(_ sender: Any) {
        print("find stations pressed")
        performSegue(withIdentifier: "stationsSegue", sender: self)
    }
 */

}
