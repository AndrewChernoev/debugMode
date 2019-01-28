//
//  DModePresenter.swift
//  DMode-Swift
//
//  Created by Chernoev Andrew on 25/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import UIKit

public final class DMPresenter {
    let controller: DMController?
    public var isPresenting: Bool = false
    
    public var leftAction: DMActionInterface?
    public var rightAction: DMActionInterface?
    
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
    
    public func reloadWithNewData(dataProvider: DMDataProviderInterface) {
        controller?.updateDataProvider(dataProvider: dataProvider)
    }
    public func show() {
        if let vc = controller {
             vc.selectItemHandler = { [weak self] (item) in
                guard let cellModel = item else { return }
                if let type = cellModel.action?.type {
                    switch type {
                    case .action:
                        if let config = cellModel.action?.config {
                            let provider = DMProvider.shared.makeDataProviderWith(config: config)
                            if let subController = DMController.load(dataProvider: provider) {
                                self?.show(viewController: subController)
                                subController.selectItemHandler = { (item) in
                                    item?.action?.callback?(item?.action)
                                    subController.navigationController?.popViewController(animated: true)
                                }
                            }
                        }
                    case .info:
                        debugPrint("info")
                    default:
                        debugPrint(type)
                    }
                }
            }
            show(viewController: vc)
        }
    }
    
    public func dismiss() {
        controller?.dismiss(animated: true, completion: { [weak self] in
            self?.isPresenting = false
        })
    }
    
    private func show(viewController: UIViewController) {
        if let visible = visibleViewController,
            visible.isKind(of: DMController.self) {
            visibleViewController?.navigationController?.show(viewController, sender: self)
        } else {
            let nvc = makeNVC(with: viewController)
            visibleViewController?.present(nvc,
                                           animated: true,
                                           completion: { [weak self] in
                self?.isPresenting = true
            })
        }
    }
    
    private func makeNVC(with root: UIViewController) -> UINavigationController {
        let vc = UINavigationController(rootViewController: root)
        if let left = leftAction {
            let button : UIBarButtonItem = UIBarButtonItem(title: left.title,
                                                           style: UIBarButtonItem.Style.plain,
                                                           target: self,
                                                           action: #selector(leftActionHandler))
            root.navigationItem.leftBarButtonItem = button
        }
        if let right = rightAction {
            let rightButton : UIBarButtonItem = UIBarButtonItem(title: right.title,
                                                              style: UIBarButtonItem.Style.plain,
                                                              target: self,
                                                              action: #selector(rightActionHandlerncel))
            root.navigationItem.rightBarButtonItem = rightButton
        }
        return vc
    }
    
    //MARK: -
    @objc func leftActionHandler() {
        leftAction?.callback?(leftAction)
        dismiss()
    }
    
    @objc func rightActionHandlerncel() {
        rightAction?.callback?(rightAction)
        dismiss()
    }

}
