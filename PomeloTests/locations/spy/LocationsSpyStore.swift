//
//  LocationsSpyStore.swift
//  PomeloTests
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

@testable import Pomelo

class LocationsSpyStore: LocationsStore {
    
    var pickupLocationsCalled = false
    var expectedResult: Result<[PickupLocationModel]>?
    
    func pickupLocations(shopId: Int, done: @escaping (Result<[PickupLocationModel]>) -> Void) {
        pickupLocationsCalled = true
        if let expectedResult = expectedResult {
            done(expectedResult)
        }
    }
}
