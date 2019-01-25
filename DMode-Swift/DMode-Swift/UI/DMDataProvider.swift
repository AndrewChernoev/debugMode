//
//  DMDataProvider.swift
//  DMode-Swift
//
//  Created by Chernoev Andrew on 25/01/2019.
//  Copyright © 2019 Chernoev Andrew. All rights reserved.
//

import UIKit

enum DMInfoType: String {
    case appVersion = "Версия приложения"
    case appName = "Имя приложения"
    case appId = "ID приложения"
    case serverURL = "URL сервера"
    
    func value() -> String? {
        switch self  {
        case .appName:
            return getAppInfoWith(key: "CFBundleName")
        case .appVersion:
            return getAppInfoWith(key: "CFBundleVersion")
        case .appId:
            return getAppInfoWith(key: "CFBundleIdentifier")
        default:
            return self.rawValue
        }
    }
    
    private func getAppInfoWith(key: String) -> String? {
        guard let value = Bundle.main.infoDictionary?[key] as? String else { return "" }
        return value
    }
}

public protocol DMDataProviderInterface {
    var items: [DMCellModel] {get set}
}

public class DMDataProvider: NSObject, DMDataProviderInterface {
    public var items: [DMCellModel] = []
    init(items: [DMCellModel]) {
        self.items = items
    }
}

extension DMDataProvider: UITableViewDataSource {
    private func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DMInfoCell",
                                                    for: indexPath) as? DMInfoCell {
            let model = items[indexPath.row]
            cell.viewModel = model
            return cell
        }
        return UITableViewCell.init()
    }
}

extension DMDataProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selected = tableView.cellForRow(at: indexPath) as? DMInfoCell {
            if let model = selected.viewModel {
                switch model.type {
                case .info :
                    debugPrint("Info action type")
                case .action:
                    debugPrint("Update action type")
                default:
                    debugPrint("Undefined action type")
                }
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
