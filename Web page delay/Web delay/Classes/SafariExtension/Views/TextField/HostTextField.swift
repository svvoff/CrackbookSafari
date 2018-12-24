//
//  HostTextField.swift
//  Web delay
//
//  Created by SOROKIN Andrey on 25/10/2018.
//  Copyright © 2018 Andrey Sorokin. All rights reserved.
//

import Cocoa

class HostTextField: NSTextField {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        var accepts = super.acceptsFirstMouse(for: event)
        if event?.type == .leftMouseDown {
            accepts = true
        }
        return accepts
    }
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
//        if event.type == .leftMouseDown {
//            becomeFirstResponder()
//        }
    }
//
    override func validateProposedFirstResponder(_ responder: NSResponder, for event: NSEvent?) -> Bool {

        return true
    }
}
