//
//  LocationsConfiguration.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//
import UIKit

class LocationsConfiguration {
    static func setup() -> UIViewController {
        let controller = LocationsViewController()
        let presenter = LocationsPresenter(view: controller)
        let interactor = LocationsInteractor(presenter: presenter)
        
        controller.locationsInteractor = interactor
        
        return controller
    }
}
