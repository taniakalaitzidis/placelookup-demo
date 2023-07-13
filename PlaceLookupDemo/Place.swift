//
//  Place.swift
//  PlaceLookupDemo
//
//  Created by Tania CATS on 7/13/23.
//

import Foundation
import MapKit
//model
struct Place: Identifiable {
    let id = UUID().uuidString
    // one stored property in this struct. mkmapitem. lots of additional data. use that data to deconstruct and get specific items that we want.
    //we're not going to access the mkmapitem outside of this struct, so we're going to use private
    private var mapItem: MKMapItem
    
    //we're going to be getting back MKMapItems from our search so we'll create an initializer to pass in new mkmapitems to create a new place
    
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
    }
    
    //computed properties based on components of the mapitem
    var name: String {
        self.mapItem.name ?? ""
    }
    
    //calculate the address value
    var address: String {
        //you don't need a return statement if there is only one line in the closure of a computed property or function
        let placemark = self.mapItem.placemark
        var cityAndState = ""
        var address = ""
        
        cityAndState = placemark.locality ?? "" // city
        if let state = placemark.administrativeArea {
            // Show either state or city, state
            cityAndState = cityAndState.isEmpty ? state : "\(cityAndState), \(state)"
        }
        address = placemark.subThoroughfare ?? "" // address number
        if let street = placemark.thoroughfare {
            // just show the street unless there is a street number, then add space + street
            address = address.isEmpty ? street : "\(address) \(street)"
        }
        
        if address.trimmingCharacters(in: .whitespaces).isEmpty && !cityAndState.isEmpty { // getting rid of any blank spaces in an address
            // no address? then just cityAndState with no space
            address = cityAndState
        } else {
            // No cityAndState? Then just address, otherwise address, cityAndState
            address = cityAndState.isEmpty ? address : "\(address), \(cityAndState)"
        }
        
        return address
    }
    
    var latitude: CLLocationDegrees {
        self.mapItem.placemark.coordinate.latitude
    }
    var longitude: CLLocationDegrees {
        self.mapItem.placemark.coordinate.longitude
    }
    
}
