//
//  FLOPageControl.swift
//  FLOPageViewController
//
//  Created by Florian Schliep on 21.01.16.
//  Copyright © 2016 Florian Schliep. All rights reserved.
//

import Cocoa

class FLOPageControl: NSControl {
    
    private var needsToRedrawIndicators = false
    
// MARK: - Appearance
    
    var color = NSColor.blackColor() {
        didSet {
            self.redrawIndicators()
        }
    }
    
    var indicatorSize: CGFloat = 7 {
        didSet {
            self.redrawIndicators()
        }
    }
    
    enum Style {
        case Dot
        case Circle
    }
    
    var style = Style.Dot {
        didSet {
            self.redrawIndicators()
        }
    }
    
// MARK: - Pages
    
    var numberOfPages: UInt = 0 {
        didSet {
            self.redrawIndicators()
        }
    }
    
    var selectedPage: UInt = 0 {
        didSet {
            self.redrawIndicators()
        }
    }
    
// MARK: - NSControl
    
    override var frame: NSRect {
        willSet {
            self.needsToRedrawIndicators = true
        }
    }

// MARK: - Drawing
    
    override func drawRect(dirtyRect: NSRect) {
        guard self.needsToRedrawIndicators else { return }
        
        if self.numberOfPages > 1 {
            for index in 0...self.numberOfPages-1 {
                var fill = true
                var frame = self.frameForIndicatorAtIndex(index)
                let lineWidth: CGFloat = 1
                
                switch (self.style, index == self.selectedPage) {
                case (.Dot, true), (.Circle, true):
                    self.color.setFill()
                case (.Dot, false):
                    self.color.colorWithAlphaComponent(0.33).setFill()
                case (.Circle, false):
                    self.color.setStroke()
                    fill = false
                    frame.insetInPlace(dx: lineWidth*0.5, dy: lineWidth*0.5)
                }
                
                let path = NSBezierPath(ovalInRect: frame)
                if fill {
                    path.fill()
                } else {
                    path.lineWidth = lineWidth
                    path.stroke()
                }
            }
        }
        
        self.needsToRedrawIndicators = false
    }
    
// MARK: - Mouse
    
    override func mouseDown(theEvent: NSEvent) {
        let location = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        self.highlightIndicatorAtLocation(location)
    }
    
    override func mouseDragged(theEvent: NSEvent) {
        let location = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        self.highlightIndicatorAtLocation(location)
    }
    
    override func mouseUp(theEvent: NSEvent) {
        let location = self.convertPoint(theEvent.locationInWindow, fromView: nil)
        self.highlightIndicatorAtLocation(location, sendAction: true)
    }
    
// MARK: - Helpers
    
    private func highlightIndicatorAtLocation(location: NSPoint, sendAction: Bool = false) {
        var newPage = self.selectedPage
        for index in 0...self.numberOfPages-1 {
            if NSPointInRect(location, self.frameForIndicatorAtIndex(index)) {
                newPage = index
                break
            }
        }
        if self.selectedPage != newPage {
            self.selectedPage = newPage
        }
        
        guard sendAction else { return }
        guard let target = self.target else { return }
        NSApp.sendAction(self.action, to: target, from: self)
    }
    
    private func frameForIndicatorAtIndex(index: UInt) -> NSRect {
        let centerDrawingAroundSpace = (self.numberOfPages % 2 == 0)
        let centeredIndex = self.numberOfPages/2
        let centeredFrame = NSRect(x: NSMidX(self.bounds) - (centerDrawingAroundSpace ? self.indicatorSize*1.5 : self.indicatorSize/2), y: NSMidY(self.bounds) - self.indicatorSize/2, width: self.indicatorSize, height: self.indicatorSize)
        let distanceToCenteredIndex = CGFloat(centeredIndex)-CGFloat(index)
        
        return NSRect(x: NSMinX(centeredFrame) - distanceToCenteredIndex*self.indicatorSize*2, y: NSMidY(self.bounds) - self.indicatorSize/2, width: self.indicatorSize, height: self.indicatorSize)
    }
    
    private func redrawIndicators() {
        self.needsToRedrawIndicators = true
        self.needsDisplay = true
    }
    
}
