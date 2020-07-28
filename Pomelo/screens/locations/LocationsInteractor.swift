//
//  LocationsInteractor.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

protocol LocationsInteractorProtocol {
    
}

class LocationsInteractor: LocationsInteractorProtocol {
    private var presenter: LocationsPresenterProtocol?
    private var locationsWorker: LocationsWorker
    
    init(presenter: LocationsPresenterProtocol, worker: LocationsWorker? = nil) {
        self.presenter = presenter
        locationsWorker = worker ?? LocationsWorker(locationsStore: LocationsRestStore())
    }
    
    
}
