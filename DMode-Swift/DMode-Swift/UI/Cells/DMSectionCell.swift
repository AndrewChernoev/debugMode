//
//  DMSectionCell.swift
//  DMode-Swift
//
//  Created by Chernoev Andrew on 28/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import UIKit

class DMSectionCell: UITableViewCell {
    @IBOutlet var title: UILabel?
    
    var viewModel: DMSectionCellModel? {
        didSet {
            self.title?.text = viewModel?.title
        }
    }
    
    static func loadNib() -> DMSectionCell? {
        let b = Bundle(identifier: "CA.DMode-Swift")
        let nib = UINib(nibName: "DMSectionCell", bundle: b)
        return nib.instantiate(withOwner: self, options: nil).first as? DMSectionCell
    }
}
