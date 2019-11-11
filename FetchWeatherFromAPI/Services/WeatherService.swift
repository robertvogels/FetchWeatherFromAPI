//
//  Services.swift
//  FetchWeatherFromAPI
//
//  Created by Robert on 06/11/2019.
//  Copyright © 2019 Robert Vogels. All rights reserved.
//
// 1. @escaping? Waarom wordt het gebruikt
// 2. Waarom moet het resultaat expliciet op de main thread?
// (2) URLSession wordt standaard op de background thread uitgevoerd. Als je iets wilt veranderen op de UI moet dat op de main
// 3. Wat is de functie van de .resume() ?

import Foundation

class WeatherService {
    
    func getWeather(city: String, completion: @escaping (Weather?) -> ()) {
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=0193ad2be63a9fcd3d17708363333975") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            if let weatherResponse = weatherResponse {
                
                let weather = weatherResponse.main
                DispatchQueue.main.async {
                    completion(weather)
                }
                
            } else {
                completion(nil)
            }
            
        }.resume()
        
    }
}
