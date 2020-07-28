//
//  LocationsInteractor.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

protocol LocationsInteractorProtocol {
    func loadLocations()
}

class LocationsInteractor: LocationsInteractorProtocol {
    private var presenter: LocationsPresenterProtocol?
    private var locationsWorker: LocationsWorker
    
    init(presenter: LocationsPresenterProtocol, worker: LocationsWorker? = nil) {
        self.presenter = presenter
        locationsWorker = worker ?? LocationsWorker(locationsStore: LocationsRestStore())
    }
    
    func loadLocations() {
        locationsWorker.pickupLocations(shopId: 1) { [weak self] (result) in
            if result.status == .success, let data = result.data {
                self?.presenter?.showLocations(locations: data.filter({ $0.active }))
            } else {
                self?.presenter?.showError(error: result.error ?? ResultError.defaultError())
            }
        }
    }
}
