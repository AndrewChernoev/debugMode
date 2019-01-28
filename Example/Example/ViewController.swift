//
//  ViewController.swift
//  Example
//
//  Created by Chernoev Andrew on 25/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import UIKit
import DMode_Swift

class ViewController: UIViewController {
    @IBOutlet open var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            label?.text = delegate.currentServer
        }
    }
    
    @IBAction func tap(_ sender: Any?) {
        DMProvider.shared.show()
    }
}

