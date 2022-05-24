//
//  DetailCountryViewController.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import UIKit
import MapKit
import WebKit

class DetailCountryViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell)
        return table
    }()
    
    private var cellHight: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        // Do any additional setup after loading the view.
        
        title = DetailCountryViewModel.shared.getCountry().name
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
                
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension DetailCountryViewController: UITableViewDelegate, UITableViewDataSource {

    func showLocation(_ mapView: MKMapView, location:CLLocation) {
        let orgLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)

        let dropPin = MKPointAnnotation()
        dropPin.coordinate = orgLocation
        mapView.addAnnotation(dropPin)
        mapView.setRegion(MKCoordinateRegion(center: orgLocation, latitudinalMeters: 500000, longitudinalMeters: 500000), animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailCountryViewModel.shared.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return DetailCountryViewModel.shared.getSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return DetailCountryViewModel.shared.getCountry().currencies.count
        case 2:
            return DetailCountryViewModel.shared.getCountry().languages.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath)
        
        let country = DetailCountryViewModel.shared.getCountry()
        
        switch indexPath.section {
        case 0:
            cellHight = 80
            cell.textLabel?.text = country.flag
            
            cell.textLabel?.font = UIFont.systemFont(ofSize: 100)
        case 1:
            cellHight = 40
            
            let name = country.currencies[indexPath.row].name
            let symbol = country.currencies[indexPath.row].symbol
            
            cell.textLabel?.text = symbol + " " + name
        case 2:
            cellHight = 40
            cell.textLabel?.text = country.languages[indexPath.row]
        default:
            cellHight = 300
            let mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cellHight))
            cell.contentView.addSubview(mapView)

            let orgLocation = CLLocation(latitude: CLLocationDegrees(country.location.lat),
                                         longitude: CLLocationDegrees(country.location.lng))
            showLocation(mapView, location: orgLocation)
        }
        
        return cell
    }
}
