//
//  LocationsPresenterTests.swift
//  PomeloTests
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Pomelo

class LocationsPresenterTests: XCTestCase {
    var sut: LocationsPresenter!
    var spyDisplay: LocationsDisplaySpy?
    
    override func setUp() {
      super.setUp()
      spyDisplay = LocationsDisplaySpy()
      sut = LocationsPresenter(view: spyDisplay!)
    }
    
    func testShowError() {
        //MARK: - When
        sut.showError(error: ResultError.defaultError())
        //MARK: - Then
        XCTAssertTrue(spyDisplay!.showErrorCalled)
        XCTAssertFalse(spyDisplay!.showLocationsCalled)
    }
    
    func testShowResult() {
        //MARK: - When
        sut.showLocations(locations: [])
        //MARK: - Then
        XCTAssertTrue(spyDisplay!.showLocationsCalled)
        XCTAssertFalse(spyDisplay!.showErrorCalled)
    }
}
