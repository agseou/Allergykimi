//
//  ViewController.swift
//  Allergykimi
//
//  Created by 은서우 on 2024/03/07.
//

import UIKit

class ViewController: BaseViewController {
    
    var searchController = UISearchController()
    let tableView = UITableView()
    
    var list: [PharmacyInfo] = [] {
        didSet {  self.tableView.reloadData() }
    }
    
    override func configureHierarchy() {
        
        
        // searchController 추가
        navigationItem.searchController = searchController
        // tableView 추가
        view.addSubview(tableView)
    }
    
    override func configureView() {
        super.configureView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .brown
        APIManager.shared.XMLrequest(api: .Pharmacy(LON: "127.085156592737", LAT: "37.4881325624879")) { xml in
            let pharmacy = Pharmacy(xml: xml)
            let items = pharmacy.response.body.items.item
            dump(items)
            self.list = items
        }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = list[indexPath.row].dutyName
        
        return cell
    }
    
}
