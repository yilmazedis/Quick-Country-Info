//
//  MKMapView+Ext.swift
//  Quick-Country-Info
//
//  Created by yilmaz on 26.05.2022.
//

import MapKit

extension MKMapView {
    func putDropPin(at location: CLLocation) {
        let location2D = CLLocationCoordinate2DMake(location.coordinate.latitude,
                                                    location.coordinate.longitude)
        let pin = MKPointAnnotation()
        pin.coordinate = location2D
        self.addAnnotation(pin)
        self.setRegion(MKCoordinateRegion(center: location2D,
                                          latitudinalMeters: 100000,
                                          longitudinalMeters: 100000),
                       animated: true)
    }
}
