//
//  ViewController.swift
//  Web page delay
//
//  Created by SOROKIN Andrey on 21/08/2018.
//  Copyright © 2018 Andrey Sorokin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.window?.styleMask.remove([.resizable])//FIXME: set window not resizable
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

