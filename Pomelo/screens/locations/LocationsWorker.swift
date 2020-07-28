//
//  LocationsWorker.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

class LocationsWorker {
    let locationsStore: LocationsStore
    
    init(locationsStore: LocationsStore) {
        self.locationsStore = locationsStore
    }
    
    func pickupLocations(done: @escaping (Result<[PickupLocationModel]>) -> Void) {
        locationsStore.pickupLocations(done: { (result) in
            done(result)
        })
    }
}
