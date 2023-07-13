//
//  PlaceLookupView.swift
//  PlaceLookupDemo
//
//  Created by Tania CATS on 7/13/23.
//

import SwiftUI
import MapKit

struct PlaceLookupView: View {
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var placeViewModel = PlaceViewModel() // we can init as a @stateobject here if this is the first or only place we'll use this ViewModel
    //create a value to hold the search text
    @State private var searchText = ""
    @Binding var returnedPlace: Place
    @Environment(\.dismiss) private var dismiss
    //show results in a list
    var body: some View {
        NavigationStack {
            List(placeViewModel.places) { place in
                VStack(alignment: .leading) {
                    Text(place.name)
                        .font(.title2)
                    Text(place.address)
                        .font(.callout)
                }
                .onTapGesture {
                    returnedPlace = place
                    dismiss()
                }
                
            }
            .listStyle(.plain)
            .searchable(text: $searchText)
            .onChange(of: searchText, perform: { text in
                if !text.isEmpty {
                    placeViewModel.search(text: text, region: locationManager.region)
                } else {
                    placeViewModel.places = []
                }
            })
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
        
    }
}

struct PlaceLookupView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceLookupView(returnedPlace: .constant(Place(mapItem: MKMapItem())))
            .environmentObject(LocationManager())
    }
}
