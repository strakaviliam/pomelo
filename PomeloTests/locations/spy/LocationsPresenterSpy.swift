//
//  LocationsPresenterSpy.swift
//  PomeloTests
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

@testable import Pomelo

class LocationsPresenterSpy: LocationsPresenterProtocol {
    
    var showErrorCalled = false
    var showLocationsCalled = false
    
    func showLocations(locations: [PickupLocationModel]) {
        showLocationsCalled = true
    }
    
    func showError(error: ResultError) {
        showErrorCalled = true
    }
}
