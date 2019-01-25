//
//  DModePresenter.swift
//  DMode-Swift
//
//  Created by Chernoev Andrew on 25/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import UIKit

final class DModePresenter {
    let controller: UIViewController? = DModeController.load()
    
    private var visibleViewController: UIViewController? {
        var currentVc = UIApplication.shared.keyWindow?.rootViewController
        while let presentedVc = currentVc?.presentedViewController {
            if let navVc = (presentedVc as? UINavigationController)?.viewControllers.last {
                currentVc = navVc
            } else if let tabVc = (presentedVc as? UITabBarController)?.selectedViewController {
                currentVc = tabVc
            } else {
                currentVc = presentedVc
            }
        }
        return currentVc
    }
    
    init() {
        
    }
    
    public func show() {
        if let vc = controller {
            visibleViewController?.present(vc, animated: true, completion: nil)
        }
    }
}
