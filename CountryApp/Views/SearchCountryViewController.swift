//
//  SearchCountry.swift
//  CountryApp
//
//  Created by yilmaz on 19.05.2022.
//

import UIKit

class SearchCountryViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cell)
        return table
    }()
    
    lazy var searchBar:UISearchBar = UISearchBar()
    var countries: [Country]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        // Do any additional setup after loading the view.
        
        title = "Continents"
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search Country"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension SearchCountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cell, for: indexPath)
        
        guard let countries = countries else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = countries[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailCountryViewController()

        vc.country = countries?[indexPath.row]

        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchCountryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        if textSearched.isEmpty {
            countries = []
            tableView.reloadData()
            return
        }
        
        print(textSearched)
        loadTableViewCells(with: textSearched)
    }
    
    private func loadTableViewCells(with what: String) {
        CountriesCaller.shared.fetchCountries(with: Constants.baseUrl + Constants.fetchByName + what) { [weak self] data in
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
}

