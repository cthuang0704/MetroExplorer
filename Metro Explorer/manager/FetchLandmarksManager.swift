//
//  FetchLandmarksManager.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/9/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import Foundation

protocol FetchLandmarksDelegate {
    func landmarksFound(_ landmarks: [Landmark])
    func landmarksNotFound(reason: FetchLandmarksManager.FailureReason)
}

class FetchLandmarksManager {
    
    enum FailureReason: String {
        case noResponse = "No response received" //allow the user to try again
        case non200Response = "Bad response" //give up
        case noData = "No data recieved" //give up
        case badData = "Bad data" //give up
    }
    
    var delegate: FetchLandmarksDelegate?
    
    func fetchLandmarks(latitude: Double, longitude: Double) {
        //default
        var urlComponents = URLComponents(string: "https://api.yelp.com/v3/businesses/search?term=landmark&latitude=37.786882&longitude=-122.399972")!
        
        urlComponents.queryItems = [
            URLQueryItem(name: "term", value: "landmark"),
            URLQueryItem(name: "latitude", value: "\(latitude)"),
            URLQueryItem(name: "longitude", value: "\(longitude)"),
        ]
        
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer 67PGR4LPMI63pQLBIjJnjSvFsFVuEjiNNQKWm8ukX9Cg4RTyON-VPepkJ--WGE9ALAWHrmRDLZ0nbgSsQHFzU87MVSs5cuvtkRUdJcJk3WyfgYrRfP3swrBEUn8NXHYx", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //PUT CODE HERE TO RUN UPON COMPLETION
            
            guard let response = response as? HTTPURLResponse else {
                self.delegate?.landmarksNotFound(reason: .noResponse)
                return
            }
            
            guard response.statusCode == 200 else {
                self.delegate?.landmarksNotFound(reason: .non200Response)
                return
            }
            
            //HERE - response is NOT nil and IS 200
            guard let data = data else {
                self.delegate?.landmarksNotFound(reason: .noData)
                return
            }
            
            //HERE - data is NOT nil
            let decoder = JSONDecoder()
            
            do {
                //let metroStationResponse = try decoder.decode(MetroStationResponse.self, from: data)
                let landmarkResponse = try decoder.decode(LandmarkResponse.self, from: data)
                
                //HERE - decoding was successful
                
                //var stations = [MetroStation]()
                var landmarks = [Landmark]()
                
                for landmark in landmarkResponse.businesses {
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
                    

//                    let landmark = Landmark(name: landmark.Name)
//                    landmark.append(landmark)
                    let landmark = Landmark(name: landmark.name, location: landmark.location,latitude: landmark.coordinates.latitude, longitude: landmark.coordinates.longitude, imageUrl: landmark.imageUrl)
                    
                    landmarks.append(landmark)
                    
                }
                
//                self.delegate?.landmarksFound(stations)
                self.delegate?.landmarksFound(landmarks)
                
                
            } catch let error {
                //if we get here, need to set a breakpoint and inspect the error to see where there is a mismatch between JSON and our Codable model structs
                print("codable failed - bad data format")
                print(error.localizedDescription)
                self.delegate?.landmarksNotFound(reason: .badData)
            }
        }
        
        print("execute request")
        task.resume()
    }
}
