//
//  ViewController.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import UIKit

class ContinentsViewController: UIViewController {
    
    var continents = [ "Asia",
                       "Europe",
                       "Africa",
                       "North America",
                       "South America",
                       "Oceania" ]
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        // Do any additional setup after loading the view.
        
        title = "Continents"
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension ContinentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return continents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath)
        
        
        cell.textLabel?.text = continents[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let id = MainScreenViewModel.shared.getUpcomingMovie(at: indexPath.row).id
        let vc = CountriesViewController()
        vc.region = continents[indexPath.row]

        navigationController?.pushViewController(vc, animated: true)
    }
    
}

