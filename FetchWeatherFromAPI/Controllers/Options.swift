//
//  Options.swift
//  FetchWeatherFromAPI
//
//  Created by Robert on 04/12/2019.
//  Copyright © 2019 Robert Vogels. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class Options {
    
    var displayInFahrenheit: Bool = false
    static let shared = Options()
    
    private init() {
        
    }
    
}

class OptionsController: ObservableObject {
    
    init() {
        isOn = Options.shared.displayInFahrenheit
    }
    
    @Published var isOn = false {
        willSet {
            Options.shared.displayInFahrenheit = newValue
        }
    }
    
}


