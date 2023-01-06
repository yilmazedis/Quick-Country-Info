//
//  CountriesViewController.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import UIKit
import SDWebImage

final class CountriesViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(PhotoViewCell.self, forCellReuseIdentifier: K.cell)
        table.separatorStyle = .none
        return table
    }()
    
    var region: String?
    private var viewModel = CountriesViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
                
        loadTableViewCells()
        configureNavigationBar(with: "Countries")
    }
    
    private func loadTableViewCells() {
        viewModel.fetchCountries(with: K.baseUrl + K.fetchByRegion + region!) { [weak self] in
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
        return viewModel.getCountryCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cell, for: indexPath) as? PhotoViewCell else {
            return UITableViewCell()
        }
        
        let country = viewModel.getCountry(at: indexPath.row)
        let name = country.name
        let nativeName = country.nativeName
        let flag = country.flag
        
        cell.configure(with: country.flagUrl)
        
        
//        cell.textLabel?.text = flag + "    " + name + " - " + nativeName
//        cell.textLabel?.labelSizeChange(into: UIFont.systemFont(ofSize: 40), from: 0, to: 4)
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        let country = viewModel.getCountry(at: indexPath.row)
        vc.viewModel.setCountry(with: country)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

