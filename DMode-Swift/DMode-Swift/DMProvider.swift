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
        presenter?.dismiss()
        presenter = DMPresenter(dataProvider: data)
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
    
    private func makeDataProviderWith(config: DMConfigurationInterface) -> DMDataProviderInterface {
        var items: [DMCellModel] = []
        
        if config.showAppInfo {
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
            userInfo.keys.forEach { (key) in
                let action = DMAction(type: DMActionType.info)
                let model = makeCellModel(action: action,
                                          title: key,
                                          subtitle: userInfo[key])
                items.append(model)
            }
        }
        
        config.actions.forEach { (action) in
            let model = makeCellModel(action: action,
                                      title: action.title ?? "",
                                      subtitle: action.description)
            items.append(model)
            
        }
        
        return DMDataProvider(items: items)
    }
    
    private func makeCellModel(action: DMActionInterface? = nil,
                               title: String = "",
                               subtitle: String? = "") -> DMCellModel {
        return DMCellModel(action: action, title: title, subtitle: subtitle)
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
