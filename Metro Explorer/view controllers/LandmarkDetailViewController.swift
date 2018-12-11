//
//  LandmarkDetailViewController.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/10/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import UIKit

class LandmarkDetailViewController: UIViewController {
    
    var landmark:Landmark?
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    @IBAction func AddressButtonPressed(_ sender: Any) {
        let link = URL(string: "http://maps.apple.com/?daddr=\(landmark!.latitude),\(landmark!.longitude)&dirflg=r")
        UIApplication.shared.openURL(link!)
        
    }
    //var metroStation: MetroStation?
    
   
    // var landmarkDetail =
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel?.text = landmark?.name
    }
    
/*    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }
*/
    @IBAction func shareButtonPressed(_ sender: Any) {
        let shareText = "Check out this landmark: "
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
