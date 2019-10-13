//
//  ContentView.swift
//  UnitConverter
//
//  Created by Dennis Dang on 10/13/19.
//  Copyright © 2019 Dennis Dang. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let volumes = ["milliliters", "liters", "cups", "pints", "gallons"]
    @State private var startingUnitSelector = 0
    @State private var targetUnitSelector = 1
    @State private var userInput = ""
    
    let unitVolumesDict = [
        "milliliters": UnitVolume.milliliters,
        "liters": UnitVolume.liters,
        "cups": UnitVolume.cups,
        "pints": UnitVolume.pints,
        "gallons": UnitVolume.gallons,
    ]
    
    func startingMeasurement() -> Measurement<UnitVolume> {
        let start = Double(userInput) ?? 0
        let initVolumeType = unitVolumesDict[volumes[startingUnitSelector]] ?? UnitVolume.milliliters
        return Measurement(value: start, unit: initVolumeType)
    }
    
    func targetMeasurement() -> Measurement<UnitVolume> {
        let targetVolumeType = unitVolumesDict[volumes[targetUnitSelector]] ?? UnitVolume.milliliters
        return startingMeasurement().converted(to: targetVolumeType)
    }
    
    var body: some View {
        Form {
            Section(header: Text("Select starting measurement")) {
                Picker("Starting unit", selection: $startingUnitSelector) {
                    ForEach(0 ..< self.volumes.count) { idx in
                        Text("\(self.volumes[idx])")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Select target measurement")) {
                Picker("Target unit", selection: $targetUnitSelector) {
                    ForEach(0 ..< self.volumes.count) { idx in
                        Text("\(self.volumes[idx])")
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Starting measure")) {
                TextField("Enter measurement", text: $userInput)
            }
            
            Section(header: Text("Converted measure")) {
                Text("\(targetMeasurement().value)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
