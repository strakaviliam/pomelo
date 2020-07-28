//
//  Router.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import UIKit

protocol Routable {
    var vc: UIViewController? { get }
}

class Router {
    
    enum PresentAs {
        case root
        case push
        case present
    }
    
    static func goTo(route: Routable, type: PresentAs = .push) {
        guard let vc = route.vc else {
            fatalError()
        }
        
        switch type {
        case .root:
            if vc is UITabBarController {
                UIApplication.keyWindow?.setRootViewController(vc)
            } else {
                UIApplication.keyWindow?.setRootViewController(UINavigationController(rootViewController: vc))
            }
        case .push:
            if let topVC = UIApplication.topViewController(), let navigation = topVC.navigationController {
                navigation.pushViewController(vc, animated: true)
            }
        case .present:
            if let topVC = UIApplication.topViewController() {
                topVC.present(vc, animated: true)
            }
        }
    }
}
