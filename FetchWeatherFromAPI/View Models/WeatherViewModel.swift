//
//  WeatherViewModel.swift
//  FetchWeatherFromAPI
//
//  Created by Robert on 06/11/2019.
//  Copyright © 2019 Robert Vogels. All rights reserved.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    private var weatherService: WeatherService!
    @Published var weather = Weather()
    var cityName = ""
    
    init() {
        self.weatherService = WeatherService()
    }
    
    var temperature: String {
        if let temp = self.weather.temp {
            return String(format: "%.0f ºC", temp-273.15)
        } else {
            return "N/A"
        }
    }
    
    func search() {
        if let city = self.cityName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            fetchWeather(city: city)
        }
    }

    private func fetchWeather(city: String) {
        
        self.weatherService.getWeather(city: city) { weather in
            if let weather = weather {
                self.weather = weather
            }
        }
    }
        
}

