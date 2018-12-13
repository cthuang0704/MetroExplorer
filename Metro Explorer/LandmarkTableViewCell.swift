//
//  LandmarkTableViewCell.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/9/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import UIKit

//element in LandmarksTableViewController
class LandmarkTableViewCell: UITableViewCell {

    @IBOutlet weak var LandmarkNameLabel: UILabel!
    @IBOutlet weak var LandmarkImage: UIImageView!
    @IBOutlet weak var LandmarkAddressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
