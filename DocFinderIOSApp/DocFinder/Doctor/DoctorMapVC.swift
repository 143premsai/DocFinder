//
//  DoctorMapVC.swift
//  DocFinder
//
//

import UIKit
import CoreLocation
import MapKit


class DoctorMapVC: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapItem: MKMapView!
    
    var doctorDetails:DoctorModel?
    
    var locationManager = CLLocationManager ()
    
    var sourceAnnotation = MKPointAnnotation()
    var destinationAnnotation = MKPointAnnotation()
    
    var userName = String();
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.CreatingMapItems()
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func CreatingMapItems(){
        
        mapItem.removeAnnotations(self.mapItem.annotations)
        mapItem.removeOverlays(self.mapItem.overlays)
        
        let docLatitude = self.doctorDetails?.latitude
        let docLongitude = self.doctorDetails?.longitude
        
        let destinationCoordinate = CLLocationCoordinate2D(latitude: docLatitude!, longitude: docLongitude!)
        
        // Do any additional setup after loading the view.
        locationManager.startUpdatingLocation()
        let sourceCoordinate = (locationManager.location?.coordinate)!
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
       
        
        sourceAnnotation.title = "\(userName)"
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        
        if let name = UserDefaults.standard.value(forKey: AppConstants.UserDefaults.name) as? String {
            userName = name
        } else {
            userName = "User"
        }
        
        destinationAnnotation.title = "Dr.\(self.doctorDetails?.name ?? "Doctor")"
        destinationAnnotation.subtitle = "\(self.doctorDetails?.address ?? "Doctor Address")"
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.mapItem.showAnnotations([sourceAnnotation, destinationAnnotation], animated: true)
        mapThis(sourceItem: sourceItem, destinationItem: destinationItem)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapItem.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        // Do any additional setup after loading the view.
        CreatingMapItems()
    }
    
    func mapThis(sourceItem : MKMapItem, destinationItem: MKMapItem) {
        
        let destinationRequest = MKDirections.Request()
        
        //start and end
        destinationRequest.source = sourceItem
        destinationRequest.destination = destinationItem
        
        // how travel
        destinationRequest.transportType = .automobile
        
        // one route = false multi = true
        destinationRequest.requestsAlternateRoutes = true
        
        let region = MKCoordinateRegion(
            center: destinationAnnotation.coordinate,
             latitudinalMeters: 50000,
             longitudinalMeters: 60000)
           mapItem.setCameraBoundary(
             MKMapView.CameraBoundary(coordinateRegion: region),
             animated: true)
           
           let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
           mapItem.setCameraZoomRange(zoomRange, animated: true)
        
        // submit request to calculate directions
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, error) in
            // if there is a response make it the response else make error
            guard let response = response else {
                if let _ = error {
                    print("something went wrong")
                }
                return
            }
            
            //we want the first respinse
            let route = response.routes[0]
            
            // adding overlay to routes
            self.mapItem.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            
            self.mapItem.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
           
        }
    
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapItem.dequeueReusableAnnotationView(withIdentifier: "person")
        
        if (annotation.title != userName) {
            
            annotationView = mapItem.dequeueReusableAnnotationView(withIdentifier: "doctor")
            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "doctor")
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = annotation
            }
        
            let pinImage = UIImage(named: "doctor")
            let size = CGSize(width: 30, height: 30)
            UIGraphicsBeginImageContext(size)
            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()

            annotationView?.image = resizedImage
            return annotationView
            
        } else {
            return annotationView
        }
        
        
        
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let routeline = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        routeline.lineWidth = 5
        routeline.strokeColor = .blue
        
        return routeline
       
    }

}
