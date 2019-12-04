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
    
    @State var cities: [String] = []
    @State var newCityEntryIsPresented: Bool = false
    @State var optionsIsPresented: Bool = false
    
    private func synchronizeList() {
        CityListWebservice.getPlacesList { list in
            if let list = list {
                self.cities = list
            }
        }
    }
    
    var body: some View {

        NavigationView {
            
            VStack {
                
                List {
                    
                    ForEach(0..<cities.count, id: \.self) { index in
                        
                        SingleView(cityName: self.cities[index])
                        
                    }.onDelete { indexSet in
                        for i in indexSet {
                            CityListWebservice.mutateOnlinePlaceList(city: self.cities[i], delete: true)
                        }
                        self.cities.remove(atOffsets: indexSet)
                        
                    }

                }
                .navigationBarTitle("Temperatures")
                .navigationBarItems(leading:
                    Button(action:{ self.optionsIsPresented = true }, label: { Text("⚙︎").fontWeight(.bold).font(.system(size: 26))})
                    , trailing: Button(action: { self.newCityEntryIsPresented = true }, label: {Text("Add").fontWeight(.bold)}))
                .sheet(isPresented: $newCityEntryIsPresented, content: { NewCityEntry(newCityEntryIsPresented: self.$newCityEntryIsPresented, addCity: { city in
                    self.cities.append(city)
                    CityListWebservice.mutateOnlinePlaceList(city: city, delete: false)
                })
                })
                
                // hidden navigationlink (for fixing the back-navigation bug):
                NavigationLink(destination: OptionsView(cities: $cities), isActive: self.$optionsIsPresented) {
                    EmptyView()
                }
                    .disabled(true)
                    .hidden()
            }
        }.onAppear(perform: synchronizeList)
        
    }
    
}
