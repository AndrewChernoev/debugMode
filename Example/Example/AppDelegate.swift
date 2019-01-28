//
//  AppDelegate.swift
//  Example
//
//  Created by Chernoev Andrew on 25/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import UIKit
import DMode_Swift

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    public var currentServer: String = "http://www.example.com"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        var selectServerAction: DMAction = DMAction()
        var actions: [DMAction] = []
        
        var newServer: String = currentServer
        
        var mainConfig = makeDefaultConfig()

        func updateCurrentServer(action: DMActionInterface?) {
            selectServerAction.description = action?.description
            newServer = action?.description ?? currentServer
            DMProvider.shared.updateConfiguration(mainConfig)
        }

        let devAction = DMAction(type: DMActionType.action,
                                 title: "Dev",
                                 description: "http://dev.example.com") { (action) in
                                    updateCurrentServer(action: action)
        }

        let stageAction = DMAction(type: DMActionType.action,
                                   title: "Test",
                                   description: "http://test.example.com") { (action) in
                                    updateCurrentServer(action: action)
        }
        
        let selectServerConfig = DMConfiguration(actions: [devAction, stageAction])
        selectServerAction = DMAction(type: DMActionType.action,
                                      title: "Change server",
                                      description: currentServer,
                                      config: selectServerConfig)
        actions.append(selectServerAction)
        
        let cancelAction = DMAction(type: DMActionType.cancel, title: "Cancel") { (action) in
            var config = self.makeDefaultConfig()
            config.addActions(actions)
            DMProvider.shared.updateConfiguration(config)
        }
        
        let saveAction = DMAction(type: DMActionType.complete, title: "Save") { [weak self] (action) in
            self?.currentServer = newServer
            if var config = self?.makeDefaultConfig() {
                config.addActions(actions)
                DMProvider.shared.updateConfiguration(config)
            }
        }
        
        actions.append(contentsOf: [saveAction, cancelAction])
        mainConfig.addActions(actions)
        DMProvider.shared.updateConfiguration(mainConfig)
        return true
    }

    private func reloadDefaultConfig(actions: [DMActionInterface]) {
        var config = makeDefaultConfig()
        config.addActions(actions)
        DMProvider.shared.updateConfiguration(config)
    }
    
    private func makeDefaultConfig() -> DMConfiguration {
        return DMConfiguration(showAppInfo: true,
                               userInfo: ["Current server:" : currentServer],
                               actions: [])
    }
    
}

