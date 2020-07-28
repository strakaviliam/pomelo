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
}

class LocationsViewController: UIViewController {
    
    var locationsInteractor: LocationsInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        
    }
}

extension LocationsViewController: LocationsDisplayProtocol {

    func showErrorAlert(title: String, msg: String?) {
        hideHud()
        popupAlert(title: title.localized(), message: msg?.localized())
    }
}
