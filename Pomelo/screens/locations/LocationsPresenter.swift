//
//  LocationsPresenter.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import UIKit

protocol LocationsPresenterProtocol: class {
    func showLocations(locations: [PickupLocationModel])
    func showError(error: ResultError)
}

class LocationsPresenter: LocationsPresenterProtocol {
    
    weak var view: LocationsDisplayProtocol?
    
    init(view: LocationsDisplayProtocol) {
        self.view = view
    }
    
    func showError(error: ResultError) {
        view?.showErrorAlert(title: error.error ?? Strings.commonError, msg: error.message ?? "")
    }
    
    func showLocations(locations: [PickupLocationModel]) {
        view?.showLocations(locations: locations)
    }
}
