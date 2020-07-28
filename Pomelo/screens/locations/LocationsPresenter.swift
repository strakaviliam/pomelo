//
//  LocationsPresenter.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import UIKit

protocol LocationsPresenterProtocol: class {
    func showError(result: Result<[PickupLocationModel]>)
}

class LocationsPresenter: LocationsPresenterProtocol {
    
    weak var view: LocationsDisplayProtocol?
    
    init(view: LocationsDisplayProtocol) {
        self.view = view
    }
    
    func showError(result: Result<[PickupLocationModel]>) {
        view?.showErrorAlert(title: result.error ?? Strings.commonError, msg: result.message ?? "")
    }
    
    
}
