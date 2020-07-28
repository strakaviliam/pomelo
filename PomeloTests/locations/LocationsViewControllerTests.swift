//
//  LocationsViewControllerTests.swift
//  PomeloTests
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Pomelo

class LocationsViewControllerTests: XCTestCase {
    var window: UIWindow!
    var sut: LocationsViewController!
    var spyInteractor: LocationsInteractorSpy?
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        spyInteractor = LocationsInteractorSpy()
        sut = LocationsViewController()
        sut.locationsInteractor = spyInteractor
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    func loadView() {
      window.addSubview(sut.view)
      RunLoop.current.run(until: Date())
    }
    
    func testCallGetLocations() {
        //MARK: - Given
        
        //MARK: - When
        loadView()
        sut.getLocations()
        
        //MARK: - Then
        XCTAssertTrue(spyInteractor!.loadLocationsCalled)
    }
    
    func testDisplayEmptyData() {
        //MARK: - Given
        let locations: [PickupLocationModel] = []
        //MARK: - When
        loadView()
        sut.showLocations(locations: locations)
        
        //MARK: - Then
        XCTAssertFalse(sut.noDataLbl.isHidden)
    }
    
    func testDisplayLocationWithoutDistance() {
        //MARK: - Given
        let pickupLocationModel = PickupLocationModel.init(fromJSON: JSON([
            "latitude": 1.0,
            "longitude": 1.0,
            "active": true
        ]))
        let locations: [PickupLocationModel] = [pickupLocationModel]
        //MARK: - When
        loadView()
        sut.showLocations(locations: locations)
        
        //MARK: - Then
        XCTAssertTrue(sut.noDataLbl.isHidden, "no data label is hidden")
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 1, "in table is 1 row")
        
        let cell = sut!.tableView(sut.tableView, cellForRowAt: IndexPath.init(row: 0, section: 0)) as? LocationTableViewCell
        XCTAssertNotNil(cell, "cell is LocationTableViewCell type")
        XCTAssertEqual(cell?.distanceLbl.text, "", "distance in cell is empty")
    }
    
    func testDisplayLocationWithDistance() {
        //MARK: - Given
        let pickupLocationModel = PickupLocationModel.init(fromJSON: JSON([
            "latitude": 1.0,
            "longitude": 1.0,
            "active": true
        ]))
        pickupLocationModel.distance = 111
        let locations: [PickupLocationModel] = [pickupLocationModel]
        //MARK: - When
        loadView()
        sut.showLocations(locations: locations)
        
        //MARK: - Then
        XCTAssertTrue(sut.noDataLbl.isHidden, "no data label is hidden")
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 1, "in table is 1 row")
        
        let cell = sut!.tableView(sut.tableView, cellForRowAt: IndexPath.init(row: 0, section: 0)) as? LocationTableViewCell
        XCTAssertNotNil(cell, "cell is LocationTableViewCell type")
        XCTAssertEqual(cell?.distanceLbl.text, "111.0 km", "distance in cell is not empty")
    }
}
