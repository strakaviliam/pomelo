//
//  LocationsWorkerTests.swift
//  PomeloTests
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Pomelo

class LocationsWorkerTests: XCTestCase {
    var sut: LocationsWorker!
    var spyStore: LocationsSpyStore?
    
    override func setUp() {
      super.setUp()
      spyStore = LocationsSpyStore()
      sut = LocationsWorker(locationsStore: spyStore!)
    }
    
    func testVerifyEmailSuccess() {
        //MARK: - Given
        spyStore?.expectedResult = Result.success(data: [])
        //MARK: - When
        sut.pickupLocations(shopId: 1) { [weak self] (result) in
            //MARK: - Then
            XCTAssertTrue(self?.spyStore?.pickupLocationsCalled ?? false)
            XCTAssertTrue(result.status == .success)
        }
     }
    
    func testVerifyEmailFail() {
        //MARK: - Given
        spyStore?.expectedResult = Result.fail(json: JSON())
        //MARK: - When
        sut.pickupLocations(shopId: 1) { [weak self] (result) in
            //MARK: - Then
            XCTAssertTrue(self?.spyStore?.pickupLocationsCalled ?? false)
            XCTAssertTrue(result.status == .fail)
        }
    }
}
