//
//  LocationsInteractor.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import CoreLocation

protocol LocationsInteractorProtocol {
    func loadLocations()
    func updateDistance(position: CLLocation?)
}

class LocationsInteractor: LocationsInteractorProtocol {
    private var presenter: LocationsPresenterProtocol?
    private var locationsWorker: LocationsWorker
    
    private var currentUserPosition: CLLocation?
    private var locations: [PickupLocationModel]?
    
    init(presenter: LocationsPresenterProtocol, worker: LocationsWorker) {
        self.presenter = presenter
        locationsWorker = worker
    }
    
    func loadLocations() {
        locationsWorker.pickupLocations(shopId: 1) { [weak self] (result) in
            if result.status == .success, let data = result.data {
                self?.locations = data
                self?.sortAndShowLocations()
            } else {
                self?.presenter?.showError(error: result.error ?? ResultError.defaultError())
            }
        }
    }
    
    func updateDistance(position: CLLocation?) {
        currentUserPosition = position
        sortAndShowLocations()
    }
    
    private func sortAndShowLocations() {
        guard locations != nil else {
            return
        }
        
        locations = locations?.filter({ $0.active })
        
        locations!.forEach { (location) in
            if let currentUserPosition = currentUserPosition, location.latitude > 0, location.longitude > 0 {
                location.distance = currentUserPosition.distance(from: CLLocation(latitude: location.latitude, longitude: location.longitude)) / 1000.0
                if (location.distance == 0.0) {
                    location.distance = nil
                }
            } else {
                location.distance = nil
            }
        }
        
        locations = locations?.sorted(by: { (l1, l2) -> Bool in
            return l1.distance ?? 99999999.0 < l2.distance ?? 99999999.0
        })
        
        presenter?.showLocations(locations: locations!)
    }
}
