//
//  DModeProvider.swift
//  DMode-Swift
//
//  Created by Chernoev Andrew on 25/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import Foundation

public final class DMProvider: UIResponder {
    public static let shared: DMProvider = DMProvider()
    private var presenter: DMPresenter?
    
    public var enabled: Bool = true
    public var configuration: DMConfigurationInterface?
    
    //MARK: - Public
    public func on() {
        enabled = true
    }
    
    public func off() {
        enabled = false
    }
    
    public func updateConfiguration(_ config: DMConfigurationInterface) {
        configuration = config
        let data = makeDataProviderWith(config: config)
        
        if presenter == nil {
            presenter = DMPresenter(dataProvider: data)
            presenter?.leftAction = config.actions.filter({ (action) -> Bool in
                return action.type == DMActionType.complete
            }).last
            
            presenter?.rightAction = config.actions.filter({ (action) -> Bool in
                return action.type == DMActionType.cancel
            }).last
        } else {
            presenter?.reloadWithNewData(dataProvider: data)
        }
        
    }
    
    //MARK: - Private
    public func show() {
        if enabled == true {
            guard let p = presenter else { return }
            if p.isPresenting {
                p.dismiss()
            } else {
                p.show()
            }
        }
    }
    
    public func makeDataProviderWith(config: DMConfigurationInterface) -> DMDataProviderInterface {
        var items: [DMCellModelInterface] = []
        
        if config.showAppInfo {
            items.append(DMSectionCellModel(title: "Application info"))
            let type = [DMInfoType.appName, DMInfoType.appId, DMInfoType.appVersion]
            type.forEach { (info) in
                let action = DMAction(type: DMActionType.info)
                let model = makeCellModel(action: action,
                                          title: info.rawValue,
                                          subtitle: info.value())
                items.append(model)
            }
        }
        
        let userInfo = config.userInfo
        if userInfo.count > 0 {
            items.append(DMSectionCellModel(title: "User info"))
            userInfo.keys.forEach { (key) in
                let action = DMAction(type: DMActionType.info)
                let model = makeCellModel(action: action,
                                          title: key,
                                          subtitle: userInfo[key])
                items.append(model)
            }
        }
        
        let userActions = config.actions.filter { (action) -> Bool in
            return action.type == .action
        }
        if userActions.count > 0 {
            items.append(DMSectionCellModel(title: "Actions"))
        }
        userActions.forEach { (action) in
            let model = makeCellModel(action: action,
                                      title: action.title ?? "",
                                      subtitle: action.description)
            items.append(model)
            
        }
        
        return DMDataProvider(items: items)
    }
    
    private func makeCellModel(action: DMActionInterface? = nil,
                               title: String = "",
                               subtitle: String? = "") -> DMInfoCellModel {
        return DMInfoCellModel(action: action, title: title, subtitle: subtitle)
    }
}

//MARK: -
extension UIViewController {
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            DMProvider.shared.show()
        }
    }
}
