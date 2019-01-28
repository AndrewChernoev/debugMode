//
//  DMCellModel.swift
//  DMode-Swift
//
//  Created by Chernoev Andrew on 25/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import Foundation

public protocol DMCellModelInterface {
    var title: String {set get}
}

public class DMInfoCellModel: DMCellModelInterface {
    public var title: String
    let subtitle: String
    let action: DMActionInterface?
    
    init(action: DMActionInterface?,
         title: String,
         subtitle: String? = "") {
        self.action = action
        self.title = title
        self.subtitle = subtitle ?? ""
    }
}
