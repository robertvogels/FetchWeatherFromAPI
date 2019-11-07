//
//  Weather.swift
//  FetchWeatherFromAPI
//
//  Created by Robert on 06/11/2019.
//  Copyright © 2019 Robert Vogels. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    
    let main: Weather
    
}

struct Weather: Decodable {
    
    var temp: Double?
    var humidity: Double?
    
}
