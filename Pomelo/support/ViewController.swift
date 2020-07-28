//
//  ViewController.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Router.goTo(route: Routes.locations, type: .root)
    }
}

