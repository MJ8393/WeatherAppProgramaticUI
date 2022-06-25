//
//  WASearchTableVC.swift
//  WeatherApp
//
//  Created by dev ios on 24/05/22.
//

import UIKit

class WASearchTableVC: UITableViewController {
    
    enum Section { case main }
    
    lazy var cities: [City]          = []
    lazy var filteredCities: [City]  = []
    let searchController             = UISearchController()
    
    var dataSourse: UITableViewDiffableDataSource<Section, City>!
    weak var delegate: WASearchTableVCDelegate!

    init(delegate: WASearchTableVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        cities        = ListOfCities().listOfCities
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableViewController()
        configureSearchController()
        configureDataSourse()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
        delegate.getCityInfo(for: filteredCities[indexPath.row])
    }
    
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        title            = "Search"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
   
    private func configureSearchController() {
       
        searchController.searchResultsUpdater                  = self
        searchController.searchBar.placeholder                 = "Search for a area"
        searchController.obscuresBackgroundDuringPresentation  = false
        navigationItem.searchController                        = searchController
        searchController.isActive                              = true
    }
    
    
    private func configureTableViewController() {
        tableView.register(WACityTableViewCell.self, forCellReuseIdentifier: WACityTableViewCell.reuseIdentifier)
        view.backgroundColor = .systemBackground
    }
    
    
    func configureDataSourse() {
        dataSourse = UITableViewDiffableDataSource<Section, City>(tableView: tableView, cellProvider: { collectionView, indexPath, city in
            let cell = self.tableView.dequeueReusableCell(withIdentifier: WACityTableViewCell.reuseIdentifier, for: indexPath) as! WACityTableViewCell
            DispatchQueue.main.async { cell.cityName = city.name }
            return cell
        })
    }
    
    
    func updateData(on cities: [City]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, City>()
        snapshot.appendSections([.main])
        snapshot.appendItems(cities)
        DispatchQueue.main.async { self.dataSourse.apply(snapshot, animatingDifferences: true) }
    }
}


extension WASearchTableVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredCities.removeAll()
            updateData(on: [])
            return
        }
        filteredCities    = cities.filter { $0.name.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredCities)
    }
}

extension WASearchTableVC: UISearchControllerDelegate {
 func didPresentSearchController(_ searchController: UISearchController) {
      DispatchQueue.main.async {[weak self] in
          self?.searchController.searchBar.becomeFirstResponder()
       }
  }
}
