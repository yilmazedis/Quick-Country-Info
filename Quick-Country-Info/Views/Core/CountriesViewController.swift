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
        CountriesViewModel.shared.fetchCountries(with: Constants.baseUrl + Constants.fetchByRegion + region!) { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
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
        return CountriesViewModel.shared.getCountryCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath)
        
//        let image = UIImageView()
//        image.sd_setImage(with: URL(string: "https://flagcdn.com/w80/za.jpg")!,
//                          placeholderImage: UIImage(systemName: "photo"))
//
//        cell.imageView?.image = image.image?.resizeImageWithHeight(newW: 60, newH: 60)
        let country = CountriesViewModel.shared.getCountry(at: indexPath.row)
        let name = country.name
        let nativeName = country.nativeName
        let flag = country.flag
        cell.textLabel?.text = flag + " - " + name + " - " + nativeName
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailCountryViewController()
        let country = CountriesViewModel.shared.getCountry(at: indexPath.row)
        DetailCountryViewModel.shared.setCountry(with: country)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

