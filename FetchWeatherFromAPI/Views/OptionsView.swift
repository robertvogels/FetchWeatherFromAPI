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
    @State var deleteAllText: String = textLabels.deleteAll.rawValue

    private func setDoneAndResetStatus() {
        self.doneText = textLabels.done.rawValue
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.doneText = ""
            self.deleteAllText = textLabels.deleteAll.rawValue
        }
    }
    
    func places() {
        self.doneText = textLabels.wait.rawValue
        CityListWebservice.getPlacesList { item in
            if let item = item {
                self.cities = item
                self.setDoneAndResetStatus()
            } else { self.doneText = textLabels.error.rawValue }
        }
    }
    
    func clearList() {
        self.doneText = textLabels.wait.rawValue
        CityListWebservice.clearOnlineList { bool in
            if bool == true {
                self.places()
                self.setDoneAndResetStatus()
            } else { self.doneText = textLabels.error.rawValue }
        }
    }
    
    
    var body: some View {
            
        NavigationView {
            
            Form {
                
                Section {
                    
                    HStack {
                        Text("Status:").fontWeight(.semibold)
                        Spacer()
                        Text(doneText)
                    }

                }
                
                Section {

                    Button(action: places, label: { Text("Synchronize local list with cloud")})
                    
                }
                
                Section {
                    
                    Button(action: {
                        if (self.deleteAllText == textLabels.sure.rawValue) {
                            self.clearList()
                        } else {
                            self.deleteAllText = textLabels.sure.rawValue
                        }
                    }, label: { Text(deleteAllText)}).foregroundColor(Color.red)
                    
                }
                
            }
            
        }
            
    }
}

