//
//  MainListView.swift
//  FetchWeatherFromAPI
//
//  Created by Robert on 06/11/2019.
//  Copyright © 2019 Robert Vogels. All rights reserved.
//

import Foundation
import SwiftUI

struct MainListView: View {
    
    @State var cities: [String]
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(0..<cities.count) { index in
                    
                    SingleView(cityName: self.cities[index])
                    
                }

            }.navigationBarTitle("Temperatures")
            
        }
        
    }
    
}
