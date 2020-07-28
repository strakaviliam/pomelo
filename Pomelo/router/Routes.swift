//
//  Routes.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import UIKit

enum Routes: Routable {
    case locations
}

extension Routes {
    var vc: UIViewController? {
        switch self {
        case .locations:
            return LocationsConfiguration.setup()
        }
    }
}
