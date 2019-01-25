//
//  DMAction.swift
//  DMode-Swift
//
//  Created by Chernoev Andrew on 25/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import Foundation

public typealias DMActionEvent = () -> DMActionInterface

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

struct DMAction: DMActionInterface {
    var type: DMActionType
    var title: String?
    var description: String?
    var callback: DMActionEvent?
}
