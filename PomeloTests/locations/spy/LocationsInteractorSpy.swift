//
//  LocationsInteractorSpy.swift
//  PomeloTests
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import CoreLocation
@testable import Pomelo

class LocationsInteractorSpy: LocationsInteractorProtocol {
    
    var loadLocationsCalled = false
    var updateDistanceCalled = false
    
    func loadLocations() {
        loadLocationsCalled = true
    }
    
    func updateDistance(position: CLLocation?) {
        updateDistanceCalled = true
    }
}
