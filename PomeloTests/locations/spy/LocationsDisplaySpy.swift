//
//  LocationsDisplaySpy.swift
//  PomeloTests
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

@testable import Pomelo

class LocationsDisplaySpy: LocationsDisplayProtocol {
    
    var showErrorCalled = false
    var showLocationsCalled = false

    func showErrorAlert(title: String, msg: String?) {
        showErrorCalled = true
    }
    
    func showLocations(locations: [PickupLocationModel]) {
        showLocationsCalled = true
    }
}
