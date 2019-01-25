//
//  DModePresenter.swift
//  DMode-Swift
//
//  Created by Chernoev Andrew on 25/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import UIKit

public final class DMPresenter {
    let controller: UIViewController?
    public var isPresenting: Bool = false
    
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
    
    init(dataProvider: DMDataProviderInterface) {
        controller = DMController.load(dataProvider: dataProvider)
    }
    
    public func show() {
        if let vc = controller {
            let nvc = makeNVC(with: vc)
            visibleViewController?.present(nvc, animated: true, completion: { [weak self] in
                self?.isPresenting = true
            })
        }
    }
    
    public func dismiss() {
        controller?.dismiss(animated: true, completion: { [weak self] in
            self?.isPresenting = false
        })
    }
    
    private func makeNVC(with root: UIViewController) -> UINavigationController {
        let vc = UINavigationController(rootViewController: root)
        let homeButton : UIBarButtonItem = UIBarButtonItem(title: "Save",
                                                           style: UIBarButtonItem.Style.done,
                                                           target: self,
                                                           action: #selector(save))
        
        let logButton : UIBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                          style: UIBarButtonItem.Style.plain,
                                                          target: self, action: #selector(cancel))

        root.navigationItem.leftBarButtonItem = homeButton
        root.navigationItem.rightBarButtonItem = logButton
        return vc
    }
    
    //MARK: -
    @objc func save() {
        dismiss()
    }
    
    @objc func cancel() {
        dismiss()
    }

}
