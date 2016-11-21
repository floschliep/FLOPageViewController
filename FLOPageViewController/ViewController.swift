//
//  ViewController.swift
//  FLOPageViewController
//
//  Created by Florian Schliep on 19.01.16.
//  Copyright © 2016 Florian Schliep. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    fileprivate weak var pageViewController: FLOPageViewController?
    
// MARK: - NSViewController
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let pageViewController = segue.destinationController as? FLOPageViewController else { return }
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        pageViewController.loadViewControllers(["1", "2", "3"], from: storyboard)
        self.pageViewController = pageViewController
    }
    
// MARK: - Page View Controller Settings
    
    @IBAction func didChangePageControlState(_ sender: NSButton) {
        self.pageViewController?.showPageControl = (sender.state == NSOnState)
    }
    
    @IBAction func didChangeArrowControlState(_ sender: NSButton) {
        self.pageViewController?.showArrowControls = (sender.state == NSOnState)
    }
    
    @IBAction func didChangePageControlMouseOverState(_ sender: NSButton) {
        self.pageViewController?.pageControlRequiresMouseOver = (sender.state == NSOnState)
    }
    
    @IBAction func didChangeArrowControlsMouseOverState(_ sender: NSButton) {
        self.pageViewController?.arrowControlsRequireMouseOver = (sender.state == NSOnState)
    }
    
    @IBAction func didChangeOverlayState(_ sender: NSButton) {
        self.pageViewController?.overlayControls = (sender.state == NSOnState)
    }
    
    @IBAction func didSelectTintColor(_ sender: NSColorWell) {
        self.pageViewController?.tintColor = sender.color
    }
    
    @IBAction func didChangeCircleIndicatorState(_ sender: NSButton) {
        self.pageViewController?.pageIndicatorStyle = (sender.state == NSOnState) ? .circle : .dot
    }
    
    @IBAction func didSelectBackgroundColor(_ sender: NSColorWell) {
        self.pageViewController?.backgroundColor = sender.color
    }
    
}
