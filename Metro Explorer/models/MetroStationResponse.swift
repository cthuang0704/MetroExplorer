//
//  MetroStationResponse.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/3/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import Foundation

struct MetroStationResponse: Codable {
    
    let Stations: [Stations]
    
}

struct Stations: Codable {
    
    let Name: String
    let Lat: Double
    let Lon: Double
    
}



