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
