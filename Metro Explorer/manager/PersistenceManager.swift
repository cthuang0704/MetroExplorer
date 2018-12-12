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
 
    func saveLandmarks(landmark: Landmark) {
        let userDefaults = UserDefaults.standard
        var landmarks = fetchLandmarks()
        
        landmarks.append(landmark)
        let encoder = JSONEncoder()
        let encodedLandmarks = try? encoder.encode(landmarks)
        userDefaults.set(encodedLandmarks, forKey: landmarksKey)
    }
    
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
    
    func fetchLandmarks() -> [Landmark] {
        let userDefaults = UserDefaults.standard
        if let landmarkData = userDefaults.data(forKey: landmarksKey), let landmarks = try?
            JSONDecoder().decode([Landmark].self, from: landmarkData){
            //workoutData is non-nil and successfully decoded
            return landmarks
        }
        else {
            return [Landmark]()
        }
    }
    func checkFavorite(landmark: Landmark) -> Bool{
        
        if fetchLandmarks().contains(where: {$0.id == landmark.id}){
            return true
        }else{
            return false
        }
    }
    
}
