//
//  FirstViewController.swift
//  NearMe
//
//  Created by Joe E. on 10/5/15.
//  Copyright © 2015 Joe E. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var myMapView: MKMapView!
    
    let lManager = CLLocationManager() //locationManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMapView.delegate = self// a class can conform to multiple protocols
        
        lManager.requestWhenInUseAuthorization() // need to ask for location
        lManager.delegate = self // the locatonManager needs to have an assigned delegate
        myMapView.showsUserLocation = true // show the user location
        lManager.startUpdatingLocation() // you want to keep updating the location. so tell the locationManager to keep updating location
        lManager.requestLocation() // request the users location only one time

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            print((location.coordinate.latitude, location.coordinate.longitude))
            
            let annotation = MKPointAnnotation()
            annotation.title = "this is cool"
            annotation.subtitle = "and fun!"
            annotation.coordinate = location.coordinate
            myMapView.addAnnotation(annotation)
            
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.image = UIImage(named: "RedOval.png")
        
        mapView.dequeueReusableAnnotationViewWithIdentifier("pin")

        annotationView.canShowCallout = true
        
        let button = UIButton(type: .DetailDisclosure)
        button.addTarget(self, action: "showDetail:", forControlEvents: .TouchUpInside)
        annotationView.rightCalloutAccessoryView = button
        
        return annotationView
        
    }
    
    func showDetail(button: UIButton) {
        if let viewController = storyboard?.instantiateViewControllerWithIdentifier("DetailVC") {
                viewController.view.backgroundColor = UIColor.lightGrayColor()
                    navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }

}

