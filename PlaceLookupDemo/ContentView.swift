//
//  ContentView.swift
//  PlaceLookupDemo
//
//  Created by Tania CATS on 7/13/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @EnvironmentObject var locationManager: LocationManager
    @State private var showPlaceLookUpSheet = false // boolean value to trigger when the sheet should be shown
    @State var returnedPlace = Place(mapItem: MKMapItem()) // click on a search result and pass it back to our original screen
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                Text("Location: \n\(locationManager.location?.coordinate.latitude ?? 0.0), \(locationManager.location?.coordinate.longitude ?? 0.0)")
                    .padding(.bottom)
                
                Text("Returned Place: \nName: \(returnedPlace.name)\nAddress:\(returnedPlace.address)\nCoords: \(returnedPlace.latitude), \(returnedPlace.longitude)")
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showPlaceLookUpSheet.toggle()
                    } label: {
                        Image(systemName: "magnifyingglass")
                        Text("Lookup Place")
                    }

                }
            }
        }
        .fullScreenCover(isPresented: $showPlaceLookUpSheet) {
            PlaceLookupView(returnedPlace: $returnedPlace)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() // Location doesn't show in Live Preview. Use simulator.
            .environmentObject(LocationManager())
    }
}
