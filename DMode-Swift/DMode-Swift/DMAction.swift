//
//  DMAction.swift
//  DMode-Swift
//
//  Created by Chernoev Andrew on 25/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import Foundation

public typealias DMActionEvent = (DMActionInterface?) -> ()

public enum DMActionType {
    case undefined
    case info
    case action
    case complete
    case cancel
}

public protocol DMActionInterface {
    var type: DMActionType {get set}
    var title: String? {get set}
    var description: String? {get set}
    var callback: DMActionEvent? {get set}
    var config: DMConfigurationInterface? {get set}
}

public class DMAction: DMActionInterface {
    public var type: DMActionType
    public var title: String?
    public var description: String?
    public var callback: DMActionEvent?
    public var config: DMConfigurationInterface?
    
    public init(type: DMActionType = DMActionType.undefined,
                title: String? = "",
                description: String? = "",
                config: DMConfigurationInterface? = nil,
                callback: DMActionEvent? = nil) {
        self.type = type
        self.title = title
        self.description = description
        self.callback = callback
        self.config = config
    }
}
