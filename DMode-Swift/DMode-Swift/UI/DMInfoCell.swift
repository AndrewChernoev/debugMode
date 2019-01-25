//
//  DMInfoCell.swift
//  DMode-Swift
//
//  Created by Chernoev Andrew on 25/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import UIKit

class DMInfoCell: UITableViewCell {
    @IBOutlet var title: UILabel?
    @IBOutlet var subTitle: UILabel?
    
    var viewModel: DMCellModel? {
        didSet {
            self.title?.text = viewModel?.title
            self.subTitle?.text = viewModel?.subtitle
        }
    }
    
    static func loadNib() -> DMInfoCell? {
        let b = Bundle(identifier: "CA.DMode-Swift")
        let nib = UINib(nibName: "DMInfoCell", bundle: b)
        return nib.instantiate(withOwner: self, options: nil).first as? DMInfoCell
    }
}
