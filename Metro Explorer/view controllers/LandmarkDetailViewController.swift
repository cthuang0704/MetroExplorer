//
//  LandmarkDetailViewController.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/10/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import UIKit
import MBProgressHUD

class LandmarkDetailViewController: UIViewController {
    
    var landmark:Landmark?
    var flag: String = ""
    let favoriteBtnImage = UIImage(named: "star-b")
    let nonfavoriteBtnImage = UIImage(named: "star-w")
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var AddressButtonText: UIButton!
    @IBOutlet weak var favoriteBtn: UIBarButtonItem!
    @IBAction func AddressButtonPressed(_ sender: Any) {
        if let link = URL(string: "http://maps.apple.com/?daddr=\(landmark!.latitude),\(landmark!.longitude)&dirflg=r"){
            UIApplication.shared.open(link, options: [:], completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        //display the landmark detail
        if let urlString = landmark?.imageUrl, let url = URL(string: urlString){
            detailImage.load(url: url)
        }
        let rating = landmark?.rating ?? 0.0
        nameLabel?.text = landmark?.name
        ratingLabel?.text = ("Rating: \(rating) /5.0")
        //change button content to landmark address
        AddressButtonText.setTitle(landmark?.location.displayAddress.joined(separator: ", "), for: UIControl.State.normal)
        MBProgressHUD.hide(for: self.view, animated: true)
        //set image of favorite button
        if PersistenceManager.sharedInstance.checkFavorite(landmark: landmark!){
            favoriteBtn.image = favoriteBtnImage
        }else{
            favoriteBtn.image = nonfavoriteBtnImage
        }
        
    }
    
/*    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        <#code#>
    }
*/
    //function of "Share" button
    //copy the landmark info and share it.
    @IBAction func shareButtonPressed(_ sender: Any) {
        let shareText = "Check out this landmark: \(landmark?.name) \(landmark?.location.displayAddress.joined(separator: ", "))"
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    //function of "Favorite" button
    //remove a landmark if it is already in favorites, else add it to favorite
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        if PersistenceManager.sharedInstance.checkFavorite(landmark: landmark!){
            PersistenceManager.sharedInstance.removeLandmarks(landmark: landmark!)
            favoriteBtn.image = nonfavoriteBtnImage
        }else{
            PersistenceManager.sharedInstance.saveLandmarks(landmark: landmark!)
            favoriteBtn.image = favoriteBtnImage
        }
    }
}
