//
//  SafariExtensionHandler.swift
//  Web delay
//
//  Created by SOROKIN Andrey on 21/08/2018.
//  Copyright © 2018 Andrey Sorokin. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {

    weak var contentManager: ContentManager! = ContentManager.shared
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        page.getPropertiesWithCompletionHandler { [weak self ] properties in
            NSLog("The extension received a message (\(messageName)) from a script injected into (\(String(describing: properties?.url))) with userInfo (\(userInfo ?? [:]))")
            guard let self = self,
                let url = properties?.url else {
                return
            }
            if self.contentManager.shouldDelay(url: url) {
                print("HA HA it is GOOGLE")
            }
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        NSLog("The extension's toolbar item was clicked")
        
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        let shared = SafariExtensionViewController.shared
        shared.output = self
        return shared
    }

}

extension SafariExtensionHandler: SafariExtensionViewControllerOutput {
    
}
