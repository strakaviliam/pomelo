//
//  LocationsViewController.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import UIKit
import Localize_Swift

protocol LocationsDisplayProtocol: class {
    func showErrorAlert(title: String, msg: String?)
    func showLocations(locations: [PickupLocationModel])
}

class LocationsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var locationsInteractor: LocationsInteractorProtocol?
    var locations: [PickupLocationModel]?
    var selectedLocations: [PickupLocationModel] = []
    
    lazy var buttonSearch: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(loadLocation))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        initView()
    }
    
    @objc func loadLocation() {
        //todo
    }
}

extension LocationsViewController: LocationsDisplayProtocol {

    func showErrorAlert(title: String, msg: String?) {
        hideHud()
        popupAlert(title: title.localized(), message: msg?.localized())
    }
    
    func showLocations(locations: [PickupLocationModel]) {
        hideHud()
        self.locations = locations
        tableView.reloadData()
    }
}

//MARK:- Configure
extension LocationsViewController {
    
    func configure(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func initView() {
        setupNavigationBar()
        registerTableCell()
        getLocations()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "locations.title".localized()
        navigationItem.rightBarButtonItems = [buttonSearch]
        
    }
    
    func getLocations() {
        showHud()
        locationsInteractor?.loadLocations()
    }
}

extension LocationsViewController: UITableViewDelegate , UITableViewDataSource {
    
    func registerTableCell() {
        let cell = UINib(nibName: "LocationTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "LocationTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = locations?.count
        return count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell") as? LocationTableViewCell,
            indexPath.row < locations?.count ?? 0,
            let location = locations?[indexPath.row] else {
                return UITableViewCell()
        }
        cell.selectedImg.image = UIImage(named: selectedLocations.contains(location) ? "check_box_checked" : "check_box")
        cell.cityLbl.text = location.city
        cell.addressLbl.text = location.address1
        cell.aliasLbl.text = location.alias
        cell.distanceLbl.text = ""
        
        if (location.alias.isEmpty) {
            cell.aliasLbl.text = "pomelo.defaultAlias".localized()
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard
            let cell = tableView.cellForRow(at: indexPath) as? LocationTableViewCell,
            let location = locations?[indexPath.row] else {
                return
        }
        
        if let index = selectedLocations.firstIndex(of: location) {
            selectedLocations.remove(at: index)
            cell.selectedImg.image = UIImage(named: "check_box")
        } else {
            selectedLocations.append(location)
            cell.selectedImg.image = UIImage(named: "check_box_checked")
        }
    }
}
