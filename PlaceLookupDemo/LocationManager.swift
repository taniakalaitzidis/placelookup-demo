//
//  LocationManager.swift
//  PlaceLookupDemo
//
//  Created by Tania CATS on 7/13/23.
//

import Foundation
import MapKit
//Mapkit actually includes corelocation as a subset, so you dohn't have to import CoreLocation

@MainActor
class LocationManager: NSObject, ObservableObject {
    @Published var location: CLLocation?
    //CL - corelocation. iOS library that works with locations. CLLocation value is going to give us access vto latitute and longitude coordinates. and if we don't have that, the value will be nil, so we use ?
    @Published var region = MKCoordinateRegion()
    
    // MARK: Get Location
    private let locationManager = CLLocationManager()
    // we don't need access to this outside of this class so we can use private
    // how are location will be determined
    override init() {
        //override - means we're replace an existingh method, or overriding it (the one that Apple already created). we first call Apple's initializer by using super.init to get all of Apple's good stuff to start
        // super.init() means first call the existing initializer (the initializer for the "super class" or parent class). the code below super.init() is executed after we first run Apple's init function - so we do all of Apple's init stuff, then set up our own additions, below this.
        super.init()
        //now we're adding all of the properties that we want to customize in our own initializer
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation() // remember to update the info.plist
        locationManager.delegate = self
        // this says when apple needs to call functions associated with the location manager, it can get the location for us, then it will pass on some calls to specific functions to our app so our ap pcan provide additional processing. the delegate pretty much says "hey iOS wants to be able to delegate certain tasks. and the "self" means this particular class, the file that we're in.
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
}
