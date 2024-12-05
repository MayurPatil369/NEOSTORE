//
//  StoreLocatorViewController.swift
//  neostore
//
//  Created by Neosoft on 29/11/24.
//

import UIKit
import MapKit

class StoreLocatorViewController: UIViewController {

    
    @IBOutlet weak var mapDisplay: MKMapView!
    @IBOutlet weak var locationTableView: UITableView!
    
    let locations: [(name: String, latitude: Double, longitude: Double)] = locationsConstants.cities
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureMap()
        
        self.title = NavigationTitleConst.StoreLocator
    }
    
    
    private func setupUI() {
        locationTableView.delegate = self
        locationTableView.dataSource = self
        locationTableView.register(UITableViewCell.self, forCellReuseIdentifier: CellConst.locationCell)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.0, green: 0.5, blue: 0.8, alpha: 1.0)
    }
    
    private func configureMap() {
        mapDisplay.delegate = self
        addAnnotations()
        
        let defaultCenter = CLLocationCoordinate2D(latitude: 21.0, longitude: 78.0)
        let mapRegion = MKCoordinateRegion(center: defaultCenter, span: MKCoordinateSpan(latitudeDelta: 12, longitudeDelta: 12))
        mapDisplay.setRegion(mapRegion, animated: true)
        
        mapDisplay.showsUserLocation = true
        mapDisplay.userTrackingMode = .follow
    }
    
    private func addAnnotations() {
        for location in locations {
            let storeAnnotation = MKPointAnnotation()
            storeAnnotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            storeAnnotation.title = location.name
            mapDisplay.addAnnotation(storeAnnotation)
        }
    }
}

extension StoreLocatorViewController: MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier:CellConst.storePin) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: CellConst.storePin)
            annotationView?.canShowCallout = true
            annotationView?.markerTintColor = .blue
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationCell = tableView.dequeueReusableCell(withIdentifier: CellConst.locationCell, for: indexPath)
        locationCell.textLabel?.text = locations[indexPath.row].name
        return locationCell
    }
}

