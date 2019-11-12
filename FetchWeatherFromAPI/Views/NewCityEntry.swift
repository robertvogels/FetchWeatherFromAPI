//
//  NewCityEntry.swift
//  FetchWeatherFromAPI
//
//  Created by Robert on 08/11/2019.
//  Copyright © 2019 Robert Vogels. All rights reserved.
//

import Foundation
import SwiftUI

struct NewCityEntry: View {
    
    @Binding var newCityEntryIsPresented: Bool
    @State var cityName: String = ""
    
    var addCity: (String) -> ()
    
    var body: some View {
            
        NavigationView {
            
            Form {
                
                Section {
                    EmptyView()
                }
                
                Section {
                    TextField(String("Enter city name here"), text: $cityName)
                }
                
                Section {
                
                    Button(action: {
                        
                        if self.cityName != "" {
                            self.addCity(self.cityName)
                            self.newCityEntryIsPresented = false
                        }

                    }, label: {Text("Add")}).foregroundColor(.green)
                    
                }
                
                Section {
                    
                    Button(action: {
                        self.newCityEntryIsPresented = false
                    }, label: { Text("Cancel")})
                }
                
            }.navigationBarTitle(Text("Add New City"))
            
        }
    }
    
}
