//
//  PersistenceManager.swift
//  Metro Explorer
//
//  Created by hct0704 on 12/10/18.
//  Copyright © 2018 hct0704. All rights reserved.
//

import Foundation

class PersistenceManager {
    static let sharedInstance = PersistenceManager()
    let landmarksKey = "landmarks"
    
    //save to favorites
    func saveLandmarks(landmark: Landmark) {
        let userDefaults = UserDefaults.standard
        var landmarks = fetchLandmarks()
        
        landmarks.append(landmark)
        let encoder = JSONEncoder()
        let encodedLandmarks = try? encoder.encode(landmarks)
        userDefaults.set(encodedLandmarks, forKey: landmarksKey)
    }
    //remove from favorites
    func removeLandmarks(landmark: Landmark){
        let userDefaults = UserDefaults.standard
        var landmarks = fetchLandmarks()
        if let index: Int = landmarks.firstIndex(where: {$0.id == landmark.id}){
            landmarks.remove(at: index)
        }
        let encoder = JSONEncoder()
        let encodedLandmarks = try? encoder.encode(landmarks)
        userDefaults.set(encodedLandmarks, forKey: landmarksKey)
    }
    //get landmarks
    func fetchLandmarks() -> [Landmark] {
        let userDefaults = UserDefaults.standard
        if let landmarkData = userDefaults.data(forKey: landmarksKey), let landmarks = try?
            JSONDecoder().decode([Landmark].self, from: landmarkData){
            return landmarks
        }
        else {
            return [Landmark]()
        }
    }
    //check if a landmark is already in Favorites by using its id
    func checkFavorite(landmark: Landmark) -> Bool{
        if fetchLandmarks().contains(where: {$0.id == landmark.id}){
            return true
        }else{
            return false
        }
    }
    
}
