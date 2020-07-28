//
//  LocationsInteractorTests.swift
//  PomeloTests
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import XCTest
import SwiftyJSON
import CoreLocation
@testable import Pomelo

class LocationsInteractorTests: XCTestCase {

    var sut: LocationsInteractor!
    var spyPresenter: LocationsPresenterSpy?
    var spyStore: LocationsSpyStore?
    
    override func setUp() {
      super.setUp()
      spyPresenter = LocationsPresenterSpy()
      spyStore = LocationsSpyStore()
      sut = LocationsInteractor(presenter: spyPresenter!, worker: LocationsWorker(locationsStore: spyStore!))
    }
    
    func testLoadLocationsSuccess() {
        //MARK: - Given
        spyStore?.expectedResult = Result.success(data: [])
        //MARK: - When
        sut.loadLocations()
        //MARK: - Then
        XCTAssertTrue(spyStore!.pickupLocationsCalled)
        XCTAssertTrue(spyPresenter!.showLocationsCalled)
        XCTAssertFalse(spyPresenter!.showErrorCalled)
     }
    
    func testLoadLocationsFail() {
        //MARK: - Given
        spyStore?.expectedResult = Result.fail(json: JSON())
        //MARK: - When
        sut.loadLocations()
        //MARK: - Then
        XCTAssertTrue(spyStore!.pickupLocationsCalled)
        XCTAssertFalse(spyPresenter!.showLocationsCalled)
        XCTAssertTrue(spyPresenter!.showErrorCalled)
    }
    
    func testUpdateDistance() {
       //MARK: - Given
        let pickupLocationModel = PickupLocationModel.init(fromJSON: JSON([
            "latitude": 1.0,
            "longitude": 1.0,
            "active": true
        ]))
        sut.locations = [pickupLocationModel]
        //MARK: - When
        sut.updateDistance(position: CLLocation(latitude: 1.0, longitude: 2.0))
        //MARK: - Then
        XCTAssertTrue(spyPresenter!.showLocationsCalled)
        XCTAssertFalse(spyPresenter!.showErrorCalled)
        XCTAssertEqual(pickupLocationModel.distance?.rounded(), 111)
    }
    
    func testUpdateDistanceWhenRemoePosition() {
       //MARK: - Given
        let pickupLocationModel = PickupLocationModel.init(fromJSON: JSON([
            "latitude": 1.0,
            "longitude": 1.0,
            "active": true
        ]))
        pickupLocationModel.distance = 1.0
        sut.locations = [pickupLocationModel]
        //MARK: - When
        sut.updateDistance(position: nil)
        //MARK: - Then
        XCTAssertTrue(spyPresenter!.showLocationsCalled)
        XCTAssertFalse(spyPresenter!.showErrorCalled)
        XCTAssertNil(pickupLocationModel.distance)
        
    }
}
