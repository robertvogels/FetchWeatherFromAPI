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
    @State var newCityEntryIsPresented: Bool = false
    
    var body: some View {

        NavigationView {
            
            List {
                
                ForEach(0..<cities.count, id: \.self) { index in
                    
                    SingleView(cityName: self.cities[index])
                    
                }.onDelete { indexSet in
                    for i in indexSet {
                        PlacesService.mutateOnlinePlaceList(city: self.cities[i], delete: true)
                    }
                    self.cities.remove(atOffsets: indexSet)
                    
                }

            }
            .navigationBarTitle("Temperatures")
            .navigationBarItems(trailing: Button(action: { self.newCityEntryIsPresented = true }, label: {Text("Add").fontWeight(.bold)}))
            .sheet(isPresented: $newCityEntryIsPresented, content: { NewCityEntry(newCityEntryIsPresented: self.$newCityEntryIsPresented, addCity: { city in
                self.cities.append(city)
                PlacesService.mutateOnlinePlaceList(city: city, delete: false)
            })
            })
        }
        
    }
    
}
