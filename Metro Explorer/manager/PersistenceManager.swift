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
 /*
    func saveLandmarks(landmark: Landmark) {
        let userDefaults = UserDefaults.standard
        
        var landmarks = fetchLandmarks()
        landmarks.append(landmark)
        
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
    
    

    func fetchWorkouts() -> [Workout] {
        let userDefaults = UserDefaults.standard
        
        if let workoutData = userDefaults.data(forKey: workoutsKey), let workouts = try? JSONDecoder().decode([Workout].self, from: workoutData) {
            //workoutData is non-nil and successfully decoded
            return workouts
        }
        else {
            return [Workout]()
        }
    }
    
   
 */
 
}
