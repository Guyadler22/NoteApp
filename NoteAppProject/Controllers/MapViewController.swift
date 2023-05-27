//
//  MapViewController.swift
//  NoteAppProject
//
//  Created by Guy Adler on 17/05/2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var note: Note?
    
    private let map:MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    func setNote(_ note: Note) {
        self.note = note
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(map)
        
        addMapPin()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    
    func addMapPin(){
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: note!.addedIn.latitude, longitude:  note!.addedIn.longtitude)
        map.setRegion(MKCoordinateRegion(
                        center:  pin.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.8,
                                               longitudeDelta: 0.8)),
                      animated: true)
        map.addAnnotation(pin)
        
        /* LocationManager.shared.resolveLocaionName(with: location) { [weak self] locationName in
         self?.title = locationName
         }*/
    }
}
