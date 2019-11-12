//
//  OptionsView.swift
//  FetchWeatherFromAPI
//
//  Created by Robert on 11/11/2019.
//  Copyright © 2019 Robert Vogels. All rights reserved.
//

import Foundation
import SwiftUI

struct OptionsView: View {
    
    @Binding var cities: [String]
    @State var doneText: String = ""
    @State var deleteAllText: String = "Delete all items from cloud"
     

    private func setDoneAndResetStatus() {
        self.doneText = "done"
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.doneText = ""
        }
    }
    
    func places() {
        self.doneText = "..."
        CityListWebservice.getPlacesList { item in
            if let item = item {
                self.cities = item
                self.setDoneAndResetStatus()
            } else { self.doneText = "error" }
        }
    }
    
    func clearList() {
        self.doneText = "..."
        CityListWebservice.clearOnlineList { bool in
            if bool == true {
                self.places()
                self.setDoneAndResetStatus()
            } else { self.doneText = "error" }
        }
    }
    
    
    var body: some View {
            
        NavigationView {
            
            Form {
                
                Section {
                    
                    HStack {
                        Text("Status:")
                        Spacer()
                        Text(doneText)
                    }

                }
                
                Section {

                    Button(action: places, label: { Text("Synchronise local list with cloud")})
                    
                }
                
                Section {
                    
                    Button(action: {
                        if (self.deleteAllText == "Sure?") {
                            self.clearList()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.deleteAllText = "Delete all items from cloud"
                            }
                            
                        } else {
                            self.deleteAllText = "Sure?"
                        }
                    }, label: { Text(deleteAllText)}).foregroundColor(Color.red)
                    
                }
                
            }
            
        }
            
    }
}

