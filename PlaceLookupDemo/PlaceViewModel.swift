//
//  PlaceViewModel.swift
//  PlaceLookupDemo
//
//  Created by Tania CATS on 7/13/23.
//

import Foundation
import MapKit

@MainActor
class PlaceViewModel: ObservableObject {
    //keep track of an array of places
    // return the places that the user searches for
    @Published var places: [Place] = []
    
    func search(text: String, region: MKCoordinateRegion) {
        //create search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = region
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("😡 ERROR: \(error?.localizedDescription ?? "Unknown Error")")
                return
            }
            self.places = response.mapItems.map(Place.init)
        }
    }
}
