//
//  ProgressModel.swift
//  Seekr
//
//  Created by Darius Ehsani on 4/19/25.
//


import SwiftUI

class ProgressModel: ObservableObject { 
    // progress bar status
    @Published var progress: Double = 0.0
    
    // unlock status
    @Published var isOneUnlocked: Bool = true
    @Published var isTwoUnlocked: Bool = false
    @Published var isThreeUnlocked: Bool = false
    @Published var isFourUnlocked: Bool = false
    
    
    // target location
    @Published var lat: Double = 0.0
    @Published var lon: Double = 0.0
    
    

}

