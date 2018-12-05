//
//  FetchMetroStationsManager.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/3/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import Foundation

protocol FetchStationsDelegate {
    func stationsFound(_ metroStations: [MetroStation])
    func stationsNotFound()
}

class FetchMetroStationsManager {
    
    var delegate: FetchStationsDelegate?
    
    func fetchStations() {
        var urlComponents = URLComponents(string: "https://api.wmata.com/Rail.svc/json/jStations?")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: "8f4b3622c3744fa68e062e2754642a51"),
           
        ]
        
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //PUT CODE HERE TO RUN UPON COMPLETION
            print("request complete")
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("response is nil or not 200")
                
                self.delegate?.stationsNotFound()
                
                return
            }
            
            //HERE - response is NOT nil and IS 200
            
            guard let data = data else {
                print("data is nil")
                
                self.delegate?.stationsNotFound()
                return
            }
            
            //HERE - data is NOT nil
            
            let decoder = JSONDecoder()
            
            do {
                let metroStationResponse = try decoder.decode(MetroStationResponse.self, from: data)
                
                //HERE - decoding was successful
                
                var stations = [MetroStation]()
                
                for station in metroStationResponse.Stations {
//                    let address = venue.location.formattedAddress.joined(separator: " ")
//
//                    let iconPrefix = venue.categories.first?.icon.prefix
//                    let iconSuffix = venue.categories.first?.icon.suffix
//
//                    var iconUrl: String? = nil
//
//                    if let iconPrefix = iconPrefix, let iconSuffix = iconSuffix {
//                        iconUrl = "\(iconPrefix)44\(iconSuffix)"
//                    }
                    
                    let station = MetroStation(name: station.Name)
                    
                    stations.append(station)
                }
                
                //now what do we do with the gyms????
                print(stations)
                
                self.delegate?.stationsFound(stations)
                
                
            } catch let error {
                //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                print("codable failed - bad data format")
                print(error.localizedDescription)
                
                self.delegate?.stationsNotFound()
            }
        }
        
        print("execute request")
        task.resume()
    }
}

