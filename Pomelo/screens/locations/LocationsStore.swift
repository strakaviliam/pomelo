//
//  LocationsStore.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import SwiftyJSON

protocol LocationsStore {
    func pickupLocations(shopId: Int, done: @escaping (Result<[PickupLocationModel]>) -> Void)
}

class LocationsRestStore: LocationsStore {
    
    private var pickupLocationsRest: Rest?
    
    init(pickupLocationsRest: Rest? = nil) {
        self.pickupLocationsRest = pickupLocationsRest ?? Rest(endpoint: "/pickup-locations", method: .get)
    }
    
    func pickupLocations(shopId: Int, done: @escaping (Result<[PickupLocationModel]>) -> Void) {
        pickupLocationsRest?.call(parameters: [
            "filter[shop_id]": shopId
        ], fail: { (json) in
            done(Result.fail(json: json))
        }, success: { (json) in
            guard let pickupList = json["pickup"].array else {
                done(Result.fail(json: json))
                return
            }
            let locations = pickupList.map({ PickupLocationModel.init(fromJSON: $0)})
            done(Result.success(data: locations))
        })
    }
}

class LocationsMockStore: LocationsStore {
    
    func pickupLocations(shopId: Int, done: @escaping (Result<[PickupLocationModel]>) -> Void) {
        
        let path = Bundle.main.path(forResource: "mock", ofType: "json")!
        let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        let json = JSON(parseJSON: jsonString!)
        
        guard let pickupList = json["pickup"].array else {
            done(Result.fail(json: json))
            return
        }
        let locations = pickupList.map({ PickupLocationModel.init(fromJSON: $0)})
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            done(Result.success(data: locations))
        }
    }
}
