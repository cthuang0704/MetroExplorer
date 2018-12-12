//
//  Landmark.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/9/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import Foundation
struct Landmark: Codable {
    let name: String
    let location: Location
    let latitude: Double
    let longitude: Double
    let rating: Double
    let id: String
    let imageUrl: String?
}
