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
    
    var selectedStop = PFObject?.self
    var stopNameSelection = PFObject?.self
    
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
        
        //self.locationManager = locationManager
        locationManager.startUpdatingLocation()
        
        /*let gestureRecognizer = UITapGestureRecognizer(target: self, action: Selector(("handleLongPress")))
        gestureRecognizer.delegate = self as? UIGestureRecognizerDelegate
        mapView.addGestureRecognizer(gestureRecognizer)*/

        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if location.horizontalAccuracy > 0 {
                locationManager.stopUpdatingLocation()
                
                let longitude = location.coordinate.longitude
                let latitude = location.coordinate.latitude
                
                print("longitude = \(longitude), latitude = \(latitude)")
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
        
        print(locCoord)
        
        //self.mapView.removeAnnotations(mapView.annotations)
        
        self.mapView.addAnnotation(annotation)
        
        
    }
    /*func locationManager(_ manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        print("got location\(newLocation.coordinate.latitude) , \(newLocation.coordinate.longitude)")
    }*/
    
    /*func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: mapView)
        let coordinates = mapView.convert(location, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        mapView.addAnnotation(annotation)
    }*/
    

    /*func handleLongPress (gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint: CGPoint = gestureRecognizer.location(in: mapView)
            let newCoordinate: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            addAnnotationOnLocation(pointedCoordinate: newCoordinate)
        }
    }
    
    func addAnnotationOnLocation(pointedCoordinate: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = pointedCoordinate
        
        print(pointedCoordinate)
        
        annotation.title = "loading.."
        annotation.subtitle = "loading... "
        
        mapView.addAnnotation(annotation)
        
        
    }*/
    /*func annotations(in mapRect: MKMapRect) -> [MKAnnotation] {
        
        
    }*/
    
    @IBAction func onCaptureGeo(_ sender: Any) {
        
        
        self.performSegue(withIdentifier: "mapToPreviewSegue", sender: self)
        
    }
    
    
    @IBAction func onBack(_ sender: Any) {
        self.performSegue(withIdentifier: "mapToCollectionSegue", sender: self)
        
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is PreviewViewController){
            let vc = segue.destination as! PreviewViewController
            vc.selectedStop = stopNameSelection
            print(stopNameSelection ?? "error 2 view")
        }
    }*/    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
