//
//  WADailyTableVC.swift
//  WeatherApp
//
//  Created by dev ios on 25/05/22.
//

import UIKit

class WADailyTableVC: UITableViewController {
    
    var items: [Daily]!
    
    init(_ items: [Daily]) {
        super.init(nibName: nil, bundle: nil)
        self.items = items
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableVC()
    }
    
    
    private func configureTableVC() {
        tableView.register(WADailyTableViewCell.self, forCellReuseIdentifier: WADailyTableViewCell.reuseIdentifier)
        tableView.separatorStyle    = .none
        tableView.backgroundColor   = .systemBackground
        tableView.isScrollEnabled   = false
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WADailyTableViewCell.reuseIdentifier, for: indexPath) as! WADailyTableViewCell
        cell.item = WADailyTableVM(items[indexPath.row])
        return cell
    }
}

