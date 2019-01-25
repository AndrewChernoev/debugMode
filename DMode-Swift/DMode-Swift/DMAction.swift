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
}

public protocol DMActionInterface {
    var type: DMActionType {get set}
    var title: String? {get set}
    var description: String? {get set}
    var callback: DMActionEvent? {get set}
}

public struct DMAction: DMActionInterface {
    public var type: DMActionType
    public var title: String?
    public var description: String?
    public var callback: DMActionEvent?
    
    public init(type: DMActionType = DMActionType.undefined,
                title: String? = "",
                description: String? = "",
                callback: DMActionEvent? = nil) {
        self.type = type
        self.title = title
        self.description = description
        self.callback = callback
    }
}
