//
//  SafariExtensionViewController.swift
//  Web delay
//
//  Created by SOROKIN Andrey on 21/08/2018.
//  Copyright © 2018 Andrey Sorokin. All rights reserved.
//

import SafariServices

protocol SafariExtensionViewControllerInput: class {

}

protocol SafariExtensionViewControllerOutput: class {

}

class SafariExtensionViewController: SFSafariExtensionViewController {

    var output: SafariExtensionViewControllerOutput?

    @IBOutlet weak var tableView: NSTableView!
    lazy var dataSource: DomenDataSourceInput = {
        let ds = DomenDataSource()
        ds.output = self
        return ds
    }()
    
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
        tableView.doubleAction = #selector(tableViewDidReceiveDoubleClickAction(_:))
    }

    @objc
    func tableViewDidReceiveDoubleClickAction(_ sender: AnyObject) {
        guard let tableView = sender as? NSTableView else {
            return
        }

        print("selected row: \(tableView.selectedRow)")
        print("selected column: \(tableView.selectedColumn)")
    }
}

extension SafariExtensionViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return dataSource.numberOfRows()
    }
}

extension SafariExtensionViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 22.0
    }

    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        let view = tableView.view(atColumn: 0, row: row, makeIfNecessary: false)
        if let tf = view as? HostTextField {
            tf.becomeFirstResponder()
        }
        return false
    }

    func tableView(_ tableView: NSTableView, didClick tableColumn: NSTableColumn) {
        print(tableColumn)
    }

//    func tableView(_ tableView: NSTableView, selectionIndexesForProposedSelection proposedSelectionIndexes: IndexSet) -> IndexSet {
//        print(proposedSelectionIndexes)
//        if let index = proposedSelectionIndexes.first {
//            let view = tableView.view(atColumn: 0, row: index, makeIfNecessary: false)
//            if let tf = view as? HostTextField {
//                tf.becomeFirstResponder()
//            }
//        }
//        return proposedSelectionIndexes
//    }

//    func tableView(_ tableView: NSTableView, sizeToFitWidthOfColumn column: Int) -> CGFloat {
//        if column == 0 {
//            return tableView.frame.size.width
//        }
//        return 0
//    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let tableColumn = tableColumn,
            tableColumn.identifier.rawValue.isEmpty == false else {
                return nil
        }
        if tableColumn.identifier.rawValue == "control" {
            return nil
        }
        if tableColumn.identifier.rawValue == "domen" {
            let tf = HostTextField(string: dataSource.string(for: row))
            tf.frame = NSRect(x: 0, y: 0, width: 100, height: 22)
            tf.delegate = self
            tf.isEditable = true
            tf.isSelectable = true
            tf.isBezeled = false

            return tf
        }

        return NSView()
    }
}

extension SafariExtensionViewController: SafariExtensionViewControllerInput {
    
}

extension SafariExtensionViewController: DomenDataSourceOutput {

}

extension SafariExtensionViewController: NSTextFieldDelegate {

    func control(_ control: NSControl, textShouldBeginEditing fieldEditor: NSText) -> Bool {
        return true
    }

    func controlTextDidChange(_ obj: Notification) {
        guard
            let tf = obj.object as? NSTextField else {
            return
        }
        if
            obj.name == NSControl.textDidChangeNotification,
            let text = obj.userInfo?["NSFieldEditor"] as? NSTextView {
            tf.stringValue = text.string.split(separator: " ").joined()
        }
    }

    func controlTextDidEndEditing(_ obj: Notification) {
        if
            let movement = obj.userInfo?["NSTextMovement"] as? Int,
            let text = obj.userInfo?["NSFieldEditor"] as? NSTextView,
            movement == NSTextMovement.return.rawValue {
            let string = text.string
            if let url = URL(string: string) {
                do {
                    try ContentManager.shared.add(host: url.absoluteString)
                } catch (ContentManager.ContentError.invalidHost) {
                    text.string = ""
                } catch {

                }
                tableView.reloadData()
            }
        } else {
            print(obj)
        }
    }
}
