//
//  SingleView.swift
//  FetchWeatherFromAPI
//
//  Created by Robert on 06/11/2019.
//  Copyright © 2019 Robert Vogels. All rights reserved.
//

import Foundation
import SwiftUI

struct SingleView: View {
    
    @ObservedObject var weatherVM: WeatherViewModel
    
    init(cityName: String) {
        self.weatherVM = WeatherViewModel()
        self.weatherVM.cityName = cityName
        self.weatherVM.search()
    }
    
    var body: some View {
        
        VStack {
            
            HStack(alignment: .center) {
                
                Text(weatherVM.cityName)
                    .frame(width: 80, alignment: .leading)
                
                Spacer()
                
                Text(weatherVM.temperature)
                
                Spacer()
                
                Button(action: {
                    self.weatherVM.search()
                    print("Search for weather from API")
                }, label: {
                    Text("Get")
                        .padding(.all, 10)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(3)
                })
                
            }.padding(.all, 6)

        }
        
    }
    
}
