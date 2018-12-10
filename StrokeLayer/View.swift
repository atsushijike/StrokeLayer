//
//  View.swift
//  StrokeLayer
//
//  Created by 寺家 篤史 on 2018/10/23.
//  Copyright © 2018 Yumemi Inc. All rights reserved.
//

import Cocoa

final class View: NSView {
    let shapeLayer = CAShapeLayer()
    var ratio: CGFloat {
        get {
            return shapeLayer.strokeEnd
        }
        set {
            shapeLayer.strokeEnd = newValue
        }
    }
    var angle: CGFloat = 0 {
        didSet {
            shapeLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 180 * angle, 0, 0, 1)
        }
    }
    var path: CGPath? {
        get {
            return shapeLayer.path
        }
        set {
            shapeLayer.path = newValue
        }
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        setup()
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setup()
    }

    private func setup() {
        wantsLayer = true

        shapeLayer.lineWidth = 7
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeColor = NSColor.green.cgColor
        shapeLayer.fillColor = NSColor.clear.cgColor
        shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        layer?.addSublayer(shapeLayer)
        path = CGPath.circle(radius: 50)
        angle = 90
    }
}
