//
//  FLOArrowControl.swift
//  FLOPageViewController
//
//  Created by Florian Schliep on 21.01.16.
//  Copyright © 2016 Florian Schliep. All rights reserved.
//

import Cocoa

class FLOArrowControl: NSControl {

    private var mouseDown = false {
        didSet {
            self.needsDisplay = true
        }
    }
    
// MARK: - Properties
    
    enum Type {
        case Left
        case Right
    }
    
    var type = Type.Left {
        didSet {
            self.needsDisplay = true
        }
    }
    
    var color = NSColor.blackColor() {
        didSet {
            self.needsDisplay = true
        }
    }
    
// MARK: - Drawing
    
    override func drawRect(dirtyRect: NSRect) {
        let drawRightArrow = self.type == .Right
        let lineWidth: CGFloat = 4
        
        let bezierPath = NSBezierPath()
        bezierPath.moveToPoint(NSPoint(x: drawRightArrow ? NSMinX(self.bounds) : NSMaxX(self.bounds), y: NSMaxY(self.bounds)))
        bezierPath.lineToPoint(NSPoint(x: drawRightArrow ? NSMaxX(self.bounds)-lineWidth*0.5 : NSMinX(self.bounds)+lineWidth*0.5, y: NSMidY(self.bounds)))
        bezierPath.lineToPoint(NSPoint(x: drawRightArrow ? NSMinX(self.bounds) : NSMaxX(self.bounds), y: NSMinY(self.bounds)))
        bezierPath.lineWidth = lineWidth
        bezierPath.lineCapStyle = .RoundLineCapStyle
        bezierPath.lineJoinStyle = .RoundLineJoinStyle
        (self.mouseDown ? self.color : self.color.colorWithAlphaComponent(0.33)).setStroke()
        bezierPath.stroke()
    }
    
// MARK: - Mouse
    
    override func mouseDown(theEvent: NSEvent) {
        super.mouseDown(theEvent)
        self.mouseDown = true
    }
    
    override func mouseUp(theEvent: NSEvent) {
        super.mouseUp(theEvent)
        self.mouseDown = false
        
        guard let target = self.target else { return }
        NSApp.sendAction(self.action, to: target, from: self)
    }
    
}
