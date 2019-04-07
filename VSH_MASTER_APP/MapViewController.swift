//
//  MapViewController.swift
//  VSH_MASTER_APP
//
//  Created by ANDREW STUDENIC on 3/28/19.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import Parse
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var geoPointArray = [PFGeoPoint]()
    
    var mvCatchObj = PFObject(className:"Stops")
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: false)
        }
        
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if location.horizontalAccuracy > 0 {
                locationManager.stopUpdatingLocation()
                
                /*let longitude = location.coordinate.longitude  // These Find the user's logitude and latitude coords
                let latitude = location.coordinate.latitude      // Keeping commented for later use
                
                print("longitude = \(longitude), latitude = \(latitude)")*/
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location failed, \(error)")
    }
    
    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        
        let location = sender.location(in: self.mapView)
        
        let locCoord = self.mapView.convert(location, toCoordinateFrom: self.mapView)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = locCoord
        annotation.title = "Place"
        annotation.subtitle = "Location of Place"
        
        let point = PFGeoPoint(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
        geoPointArray.append(point)
        
        //print(locCoord)
        
        //self.mapView.removeAnnotations(mapView.annotations) <-- How to remove annotations
        
        self.mapView.addAnnotation(annotation)
    }
    
    @IBAction func onCaptureGeo(_ sender: Any) {
        
        let polygon = PFPolygon(coordinates: geoPointArray)
        mvCatchObj["stopCoords"] = polygon
        
        self.performSegue(withIdentifier: "mapToPreviewSegue", sender: self)
    }
    
    @IBAction func onBack(_ sender: Any) {
        
        self.performSegue(withIdentifier: "mapToCollectionSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is PreviewViewController){
            let vc = segue.destination as! PreviewViewController
            vc.pvCatchObj = mvCatchObj
        }
    }
}
