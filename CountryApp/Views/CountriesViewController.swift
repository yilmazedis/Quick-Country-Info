//
//  CountriesViewController.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import UIKit
import SDWebImage

class CountriesViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell)
        return table
    }()
    
    var region: String?
    
    var countries: [Countries]?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        // Do any additional setup after loading the view.
        
        title = "Countries"
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        print(region!)
        
        loadTableViewCells()
        

        
       
        
    }
    
    private func loadTableViewCells() {
        CountriesCaller.shared.fetchCountries(with: Constants.baseUrl + Constants.fetchByRegion + region!) { [weak self] data in
            switch data {
            case.success(let results):
                DispatchQueue.main.async {
                    self?.countries = results
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath)
        
        guard let countries = countries else {
            return UITableViewCell()
        }
        
        let image = UIImageView()
        image.sd_setImage(with: URL(string: countries[indexPath.row].flags.png)!,
                                    placeholderImage: UIImage(systemName: "photo"))

        cell.imageView?.image = image.image?.resizeImageWithHeight(newW: 60, newH: 60)
        
        let key = countries[indexPath.row].name.nativeName.keys.first!
        let name = countries[indexPath.row].name.common
        let common = countries[indexPath.row].name.nativeName[key]!["common"]!

        cell.textLabel?.text = name + " - " + common
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailCountryViewController()
        vc.country = countries?[indexPath.row]

        navigationController?.pushViewController(vc, animated: true)
    }
    
}

