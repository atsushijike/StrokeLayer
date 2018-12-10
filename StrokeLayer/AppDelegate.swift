//
//  AppDelegate.swift
//  StrokeLayer
//
//  Created by 寺家 篤史 on 2018/10/23.
//  Copyright © 2018 Yumemi Inc. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var view: View!
    @IBOutlet weak var ratioLabel: NSTextField!
    
    enum Style: Int {
        case circle = 0, rounded = 1, bell = 2, freehand = 3
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        view.ratio = 0.5
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    @IBAction func percentSliderValueChanged(_ sender: NSSlider) {
        let value = sender.floatValue
        view.ratio = CGFloat(value)
        ratioLabel.stringValue = String(floor(value * 10) / 10)
    }
    
    @IBAction func popUpMenuSelected(_ sender: NSPopUpButton) {
        guard let tag = sender.selectedItem?.tag, let style = Style(rawValue: tag) else { return }
        
        var path: CGPath?
        let size: CGFloat = 100
        switch style {
        case .circle:
            path = CGPath.circle(radius: (size / 2))
        case .rounded:
            path = CGPath.rounded(rect: CGRect(x: -(size / 2), y: -(size / 2), width: size, height: size), corner: 12)
        case .bell:
            path = CGPath.image(name: "bell", withExtension: "svg")
        case .freehand:
            let canvasPath = canvasView.path
            let boundingBox = canvasPath.boundingBox
            // rotate & translate
            var transform = CGAffineTransform(rotationAngle: CGFloat.pi / 180 * -90)
            transform = transform.translatedBy(x: -boundingBox.midX, y: -boundingBox.midY)
            path = canvasPath.copy(using: &transform)
        }
        view.path = path
    }
}

