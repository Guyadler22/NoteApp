//
//  LocationManager.swift
//  NoteAppProject
//
//  Created by Guy Adler on 17/05/2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    
    var completion: ((CLLocation) -> Void)?
    
    public func getUserLocation(completion: @escaping (CLLocation) -> Void ){
        self.completion = completion
      
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    public func resolveLocaionName(with location:CLLocation,completion: @escaping ((String?) -> Void)) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { (placemarks, error) in
            guard let place = placemarks?.first, error == nil else {
                completion(nil)
                return
            }
            print(place)
            var name = ""
            
            if let locality = place.locality {
                name += locality
            }
             
            if let adminRegion = place.administrativeArea {
                name += ", \(adminRegion)"
            }
            completion(name)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("0.222")
        guard let location = locations.first else {
            print("location null")
            return
        }
        completion?(location)
        manager.stopUpdatingLocation()
    }
    
}
