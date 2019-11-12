//
//  PlacesService.swift
//  FetchWeatherFromAPI
//
//  Created by Robert on 10/11/2019.
//  Copyright © 2019 Robert Vogels. All rights reserved.
//

import Foundation

class CityListWebservice {
    
    static func getPlacesList(completion: @escaping ([String]?) -> ()) {
        
        guard let url = URL(string: "https://reinvented-postage.glitch.me/weatherplaces") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let placeList = try? JSONDecoder().decode([String].self, from: data)
            
            if let placeList = placeList {
                
                let placeList = placeList
                DispatchQueue.main.async {
                    completion(placeList)
                }
                
            } else {
                completion(nil)
            }
            
        }.resume()
        
    }
    
    static func mutateOnlinePlaceList(city: String, delete: Bool) {
        
        let citydict = ["name": city]
        var option = ""
        
        if delete {
            option = "delete"
        }
        
        guard let url = URL(string: "https://reinvented-postage.glitch.me/\(option)weatherplaces") else {
            print("url-error")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(citydict)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error == nil {
                return
            } else {
                print("data-encoding error")
            }
            
        }.resume()
        
    }
    
    static func clearOnlineList(completion: @escaping (Bool?) -> ()) {
        
        
        guard let url = URL(string: "https://reinvented-postage.glitch.me/clearweatherplaces") else {
            print("url-error")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }.resume()
        
    }
    
}
