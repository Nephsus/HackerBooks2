//
//  MapController.swift
//  HackerBooks2
//
//  Created by David Cava Jimenez on 28/2/17.
//  Copyright © 2017 David Cava Jimenez. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController, MKMapViewDelegate {
    
    var annotations : [Annotation]!
    
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        for annotation in annotations{
            
            if let latitud = annotation.localization?.latitud,
                let longitud = annotation.localization?.longitud
            {
                print("Latitud: \(latitud)")
                print("Longitud:\(longitud)")
                let at = MapPin(coordinate: CLLocationCoordinate2D(latitude: latitud,
                                                                   longitude:  longitud))
                at.title = annotation.text ?? "Not Defined"
                
                self.mapView.addAnnotation(at)

            }
        }
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // Better to make this class property
        let annotationIdentifier = "AnnotationIdentifier"
        
        var annotationView: MKAnnotationView?
        if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) {
            annotationView = dequeuedAnnotationView
            annotationView?.annotation = annotation
        }
        else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        if let annotationView = annotationView {
            // Configure your annotation view here
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "marker")
        }
        
        return annotationView
    }
    
    

}

class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
