//
//  ColoredView.swift
//  FLOPageViewController
//
//  Created by Florian Schliep on 20.01.16.
//  Copyright © 2016 Florian Schliep. All rights reserved.
//

import Cocoa

@IBDesignable class ColoredView: NSView {

    @IBInspectable var backgroundColor: NSColor = .windowBackgroundColor {
        didSet {
            self.needsDisplay = true
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        self.backgroundColor.setFill()
        NSRectFill(self.bounds)
    }
    
}
