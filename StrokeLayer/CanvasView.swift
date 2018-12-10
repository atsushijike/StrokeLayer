//
//  CanvasView.swift
//  StrokeLayer
//
//  Created by 寺家 篤史 on 2018/12/05.
//  Copyright © 2018 Yumemi Inc. All rights reserved.
//

import AppKit

final class CanvasView: NSView {
    var path = CGMutablePath()
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let context = NSGraphicsContext.current?.cgContext
        context?.saveGState()
        context?.setStrokeColor(NSColor.green.cgColor)
        context?.setLineWidth(7)
        context?.addPath(path)
        context?.strokePath()
        context?.restoreGState()
    }
    
    override func mouseDown(with event: NSEvent) {
        path = CGMutablePath()
        path.move(to: convert(event.locationInWindow, from: nil))
        needsDisplay = true
    }
    
    override func mouseDragged(with event: NSEvent) {
        path.addLine(to: convert(event.locationInWindow, from: nil))
        needsDisplay = true
    }
}
