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
    func stationsNotFound(reason: FetchMetroStationsManager.FailureReason)
}

class FetchMetroStationsManager {
    
    enum FailureReason: String {
        case noResponse = "No response received" //allow the user to try again
        case non200Response = "Bad response" //give up
        case noData = "No data recieved" //give up
        case badData = "Bad data" //give up
    }
    
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
            guard let response = response as? HTTPURLResponse else {
                self.delegate?.stationsNotFound(reason: .noResponse)
                return
            }
            guard response.statusCode == 200 else {
                self.delegate?.stationsNotFound(reason: .non200Response)
                return
            }
            //response is NOT nil and IS 200
            guard let data = data else {
                self.delegate?.stationsNotFound(reason: .noData)
                return
            }
            //data is NOT nil
            let decoder = JSONDecoder()
            
            do {
                let metroStationResponse = try decoder.decode(MetroStationResponse.self, from: data)
                
                //decoding is successful
                var stations = [MetroStation]()
                for station in metroStationResponse.Stations {
                    let station = MetroStation(name: station.Name, latitude: station.Lat, longitude: station.Lon)
                    stations.append(station)
                }
                self.delegate?.stationsFound(stations)
            } catch let error {
                print("codable failed - bad data format")
                print(error.localizedDescription)
                self.delegate?.stationsNotFound(reason: .badData)
            }
        }
        
        print("execute request")
        task.resume()
    }
}

