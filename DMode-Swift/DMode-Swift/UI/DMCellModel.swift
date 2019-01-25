//
//  DMCellModel.swift
//  DMode-Swift
//
//  Created by Chernoev Andrew on 25/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import Foundation

public class DMCellModel {
    let title: String
    let subtitle: String
    let type: DMActionType
    
    init(type: DMActionType = .undefined,
         title: String,
         subtitle: String? = "") {
        self.type = type
        self.title = title
        self.subtitle = subtitle ?? ""
    }
}
