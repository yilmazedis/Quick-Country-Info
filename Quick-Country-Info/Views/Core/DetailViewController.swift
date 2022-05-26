//
//  DetailViewController.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import UIKit
import MapKit

final class DetailViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: K.cell)
        return table
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        configureNavigationBar(with: DetailViewModel.shared.getCountry().name)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(DetailViewModel.shared.cellHight)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailViewModel.shared.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return DetailViewModel.shared.getSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case CellSections.flag.rawValue:
            return 1
        case CellSections.curency.rawValue:
            return DetailViewModel.shared.getCountry().currencies.count
        case CellSections.languages.rawValue:
            return DetailViewModel.shared.getCountry().languages.count
        case CellSections.map.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cell, for: indexPath)
        
        let country = DetailViewModel.shared.getCountry()
        
        switch indexPath.section {
        case CellSections.flag.rawValue:
            DetailViewModel.shared.setCellHight(when: .flag)
            
            cell.textLabel?.text = country.flag
            cell.textLabel?.font = UIFont.systemFont(ofSize: CGFloat(K.DetailView.flagHight))
            
        case CellSections.curency.rawValue:
            DetailViewModel.shared.setCellHight(when: .curency)
            
            let name = country.currencies[indexPath.row].name
            let symbol = country.currencies[indexPath.row].symbol
            cell.textLabel?.text = symbol + " " + name
            
        case CellSections.languages.rawValue:
            DetailViewModel.shared.setCellHight(when: .languages)
            
            cell.textLabel?.text = country.languages[indexPath.row]
            
        case CellSections.map.rawValue:
            DetailViewModel.shared.setCellHight(when: .map)
            
            let mapView = MKMapView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: Int(cell.frame.size.width),
                                                  height: K.DetailView.mapHight))
            cell.contentView.addSubview(mapView)

            let location = CLLocation(latitude: CLLocationDegrees(country.location.lat),
                                      longitude: CLLocationDegrees(country.location.lng))
            mapView.putDropPin(at: location)
            
        default: break
        }
        return cell
    }
}

