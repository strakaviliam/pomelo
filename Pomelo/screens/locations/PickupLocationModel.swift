//
//  PickupLocationModel.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import SwiftyJSON

class PickupLocationModel: Equatable {
    let id: Int
    let alias: String
    let address1: String
    let city: String
    let active: Bool
    let latitude: Double
    let longitude: Double
    
    var distance: Double?
    
    init(fromJSON json: JSON) {
        id = json["id_pickup_location"].int ?? json["id_partner_store"].intValue
        alias = json["alias"].stringValue
        address1 = json["address1"].stringValue
        city = json["city"].stringValue
        active = json["active"].boolValue
        latitude = json["latitude"].doubleValue
        longitude = json["longitude"].doubleValue
    }
    
    static func ==(lhs: PickupLocationModel, rhs: PickupLocationModel) -> Bool {
        return lhs.id == rhs.id && lhs.alias == rhs.alias
    }
}
