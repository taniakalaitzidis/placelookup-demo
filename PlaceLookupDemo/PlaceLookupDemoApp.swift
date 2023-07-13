//
//  PlaceLookupDemoApp.swift
//  PlaceLookupDemo
//
//  Created by Tania CATS on 7/13/23.
//

import SwiftUI

@main
struct PlaceLookupDemoApp: App {
    //setting up the environment object
    @StateObject var locationManager = LocationManager() //object of the LocationManager class
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
        }
    }
}
