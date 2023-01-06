//
//  ViewController.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import UIKit

final class ContinentsViewController: UITableViewController {
    
    private let viewModel = ContinentsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(with: "Continents")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.cell)
    }
}

// MARK: - Devide tableView functions -
extension ContinentsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getContinentCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cell, for: indexPath)
        
        cell.textLabel?.text = viewModel.getContinent(at: indexPath.row)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CountriesViewController()
        vc.region = viewModel.getContinent(at: indexPath.row)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(K.cellHight)
    }
}
