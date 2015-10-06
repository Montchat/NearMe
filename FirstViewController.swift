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
    
    var textForString: String?

    @IBOutlet weak var myMapView: MKMapView!
    let lManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMapView.delegate = self
        myMapView.showsUserLocation = true

        lManager.delegate = self
        lManager.requestWhenInUseAuthorization()
        lManager.startUpdatingLocation()

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
            
            textForString = annotation.title
            myMapView.addAnnotation(annotation)
            
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.10, longitudeDelta: 0.10 ))
            
            self.myMapView.setRegion(region, animated: true)
            
        }
        
        lManager.stopUpdatingLocation()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let locationInView = touch.locationInView(view)
            let convertedPoint = self.myMapView.convertPoint(locationInView, toCoordinateFromView: self.view)
            
            let annotation = MKPointAnnotation()
            annotation.title = "this is also cool"
            annotation.subtitle = "and also fun"
            annotation.coordinate = convertedPoint
            
            textForString = annotation.title
            myMapView.addAnnotation(annotation)
            
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        annotationView.image = UIImage(named: "RedOval")

        mapView.dequeueReusableAnnotationViewWithIdentifier("pin")

        annotationView.canShowCallout = true
       
        let button = UIButton(type: .DetailDisclosure)
        button.addTarget(self, action: "showDetail:", forControlEvents: .TouchUpInside)
        annotationView.rightCalloutAccessoryView = button
        
        return annotationView

    }
    
    
    func showDetail(button: UIButton) {
        if let viewController = storyboard?.instantiateViewControllerWithIdentifier("DetailVC") as? DetailViewController {
                viewController.view.backgroundColor = UIColor.lightGrayColor()
                    navigationController?.pushViewController(viewController, animated: true)
            viewController.detailLabel?.text = textForString

        }
        
    }

}

