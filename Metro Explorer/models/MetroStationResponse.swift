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
    
//    let Code: String
    let Name: String
//    let StationTogether1: String
//    let StationTogether2: String
//    let LineCode1: String
//    let LineCode2: LineCode2
//    let LineCode3: LineCode3
//    let LineCode4: LineCode4
    let Lat: Double
    let Lon: Double
//    let Address: Address
    
}

//struct Address: Codable {
//
//    let Street: String
//    let City: String
//    let State: String
//    let Zip: String
//
//}

