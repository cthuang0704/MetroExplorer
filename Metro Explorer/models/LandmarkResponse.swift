//
//  LandmarkResponse.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/9/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import Foundation
struct LandmarkResponse: Codable {
    
    let businesses: [Businesses]
    
}

struct Businesses: Codable {
    
    let id: String
    let name: String
    let imageUrl: String?
    let rating: Double
    let coordinates: Coordinates
    let location: Location
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
        case rating
        case coordinates
        case location
    }
}

struct Coordinates: Codable {

    let latitude: Double
    let longitude: Double

}

struct Location: Codable {
    
    let displayAddress: [String]
    
    private enum CodingKeys: String, CodingKey {
        case displayAddress = "display_address"
    }
}


