//
//  LocationsStore.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

protocol LocationsStore {
    func pickupLocations(done: @escaping (Result<[PickupLocationModel]>) -> Void)
}

class LocationsRestStore: LocationsStore {
    
    private var pickupLocationsRest: Rest?
    
    init(pickupLocationsRest: Rest? = nil) {
        self.pickupLocationsRest = pickupLocationsRest ?? Rest(endpoint: "/pickup-locations", method: .get)
    }
    
    func pickupLocations(done: @escaping (Result<[PickupLocationModel]>) -> Void) {
        //todo
    }
}
