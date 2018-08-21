//
//  SafariExtensionViewController.swift
//  Web delay
//
//  Created by SOROKIN Andrey on 21/08/2018.
//  Copyright © 2018 Andrey Sorokin. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:240)
        return shared
    }()

}
