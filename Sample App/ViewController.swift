//
//  ViewController.swift
//  FLOPageViewController
//
//  Created by Florian Schliep on 19.01.16.
//  Copyright © 2016 Florian Schliep. All rights reserved.
//

import Cocoa
import FLOPageViewController

class ViewController: NSViewController {
    
    fileprivate weak var pageViewController: PageViewController?
    
// MARK: - NSViewController
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let pageViewController = segue.destinationController as? PageViewController else { return }
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        pageViewController.loadViewControllers(["1", "2", "3"], from: storyboard)
        self.pageViewController = pageViewController
    }
    
// MARK: - Page View Controller Settings
    
    @IBAction func didChangePageControlState(_ sender: NSButton) {
        self.pageViewController?.showPageControl = (sender.state == .on)
    }
    
    @IBAction func didChangeArrowControlState(_ sender: NSButton) {
        self.pageViewController?.showArrowControls = (sender.state == .on)
    }
    
    @IBAction func didChangePageControlMouseOverState(_ sender: NSButton) {
        self.pageViewController?.pageControlRequiresMouseOver = (sender.state == .on)
    }
    
    @IBAction func didChangeArrowControlsMouseOverState(_ sender: NSButton) {
        self.pageViewController?.arrowControlsRequireMouseOver = (sender.state == .on)
    }
    
    @IBAction func didChangeOverlayState(_ sender: NSButton) {
        self.pageViewController?.overlayControls = (sender.state == .on)
    }
    
    @IBAction func didSelectTintColor(_ sender: NSColorWell) {
        self.pageViewController?.tintColor = sender.color
    }
    
    @IBAction func didChangeCircleIndicatorState(_ sender: NSButton) {
        self.pageViewController?.pageIndicatorStyle = (sender.state == .on) ? .circle : .dot
    }
    
    @IBAction func didSelectBackgroundColor(_ sender: NSColorWell) {
        self.pageViewController?.backgroundColor = sender.color
    }
    
}
