//
//  UITools.swift
//  Pomelo
//
//  Created by Viliam Straka on 28/07/2020.
//  Copyright © 2020 Viliam Straka. All rights reserved.
//

import UIKit
import JGProgressHUD
import Localize_Swift

extension UIApplication {
    
    class var keyWindow: UIWindow? {
        return UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    }
    
    class func topViewController(_ base: UIViewController? = UIApplication.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            let top = self.topViewController(nav.visibleViewController)
            return top
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                let top = self.topViewController(selected)
                return top
            }
        }
        
        if let presented = base?.presentedViewController {
            let top = self.topViewController(presented)
            return top
        }
        return base
    }
}

extension UIWindow {
    func setRootViewController(_ controller: UIViewController) {
        self.rootViewController = controller
        self.makeKeyAndVisible()
    }
}

extension UIViewController {
    static let hud = JGProgressHUD(style: .dark)
    
    func popupAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showHud() {
        UIViewController.hud.show(in: self.view)
    }
    
    func hideHud() {
        UIViewController.hud.dismiss()
    }
}
