//
//  DModeController.swift
//  DMode-Swift
//
//  Created by Chernoev Andrew on 24/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import UIKit

public class DMController: UIViewController {
    
    @IBOutlet var appInfoTableView: UITableView?
    
    private var dataProvider: DMDataProviderInterface? {
        didSet {
            reloadData()
        }
    }
    
    public static func load(dataProvider: DMDataProviderInterface?) -> DMController? {
        guard let bundle = DMController.currentBundle() else { return nil }
        let storyboard = UIStoryboard(name: "DMStoryBoard",
                                      bundle: bundle
        )
        if let vc = storyboard.instantiateViewController(withIdentifier: "DMController") as? DMController {
            vc.dataProvider = dataProvider
            return vc
        }
        return nil
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    private func reloadData() {
        guard isViewLoaded else { return }
        if let ds = dataProvider as? UITableViewDataSource {
            appInfoTableView?.dataSource = ds
        }
        if let delegate = dataProvider as? UITableViewDelegate {
            appInfoTableView?.delegate = delegate
        }
        appInfoTableView?.reloadData()
    }
    
    private static func currentBundle() -> Bundle? {
        return Bundle(identifier: "CA.DMode-Swift")
    }
    
}
