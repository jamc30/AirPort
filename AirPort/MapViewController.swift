//
//  MapViewController.swift
//  AirPort
//
//  Created by Juan Antonio Martin on 11/06/21.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var data : DataItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabItem2 = self.tabBarController as! TabBarViewController
        data = tabItem2.data
        self.fetchStadiumsOnMap(data)
    }
    
    func fetchStadiumsOnMap(_ stadiums: DataItem) {
        for airPorts in stadiums.items {
            let annotations = MKPointAnnotation()
            annotations.title = airPorts.name
            annotations.coordinate = CLLocationCoordinate2D(latitude:
                                                                Double(airPorts.location.lat), longitude: Double(airPorts.location.lon))
            
            mapView.addAnnotation(annotations)
        }
    }

}
