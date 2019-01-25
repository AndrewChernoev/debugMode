//
//  DMConfiguration.swift
//  DMode-Swift
//
//  Created by Chernoev Andrew on 25/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import Foundation

public protocol DMConfigurationInterface {
    var showAppInfo: Bool {get set}
    var userInfo: [String:String] {get set}
    var actions:[DMActionInterface] {get set}
}

public struct DMConfiguration: DMConfigurationInterface {
    public var showAppInfo: Bool
    public var userInfo: [String : String]
    public var actions: [DMActionInterface]
    
    public init(showAppInfo: Bool = false,
                userInfo: [String : String] = [:],
                actions: [DMActionInterface] = []) {
        self.showAppInfo = showAppInfo
        self.userInfo = userInfo
        self.actions = actions
    }
}
