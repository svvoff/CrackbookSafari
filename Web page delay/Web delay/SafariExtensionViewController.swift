//
//  SafariExtensionViewController.swift
//  Web delay
//
//  Created by SOROKIN Andrey on 21/08/2018.
//  Copyright © 2018 Andrey Sorokin. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {

    @IBOutlet weak var tableView: NSTableView!
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:480, height:320)
        return shared
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.headerView = nil
        tableView.columnAutoresizingStyle = .sequentialColumnAutoresizingStyle
    }
}

extension SafariExtensionViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 10
    }
}

extension SafariExtensionViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 44.0
    }

    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }

//    func tableView(_ tableView: NSTableView, sizeToFitWidthOfColumn column: Int) -> CGFloat {
//        if column == 0 {
//            return tableView.frame.size.width
//        }
//        return 0
//    }
}
