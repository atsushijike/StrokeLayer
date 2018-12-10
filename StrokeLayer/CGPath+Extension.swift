//
//  CGPath+Extension.swift
//  StrokeLayer
//
//  Created by 寺家 篤史 on 2018/11/30.
//  Copyright © 2018 Yumemi Inc. All rights reserved.
//

import Foundation
import PocketSVG

extension CGPath {
    class func circle(radius: CGFloat) -> CGPath? {
        let path = CGMutablePath()
        path.addArc(center: .zero, radius: radius, startAngle: 0, endAngle: CGFloat.pi  * 2, clockwise: true)
        return path
    }
    
    class func rounded(rect: CGRect, corner: CGFloat) -> CGPath? {
        let path = CGMutablePath()
        if #available(macOS 10.14, *) {
            path.addRoundedRect(in: rect, cornerWidth: corner, cornerHeight: corner)
            // clockwise
            var scale = CGAffineTransform(scaleX: 1.0, y: -1.0)
            return path.copy(using: &scale)
        } else {
            path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + corner))
            path.addCurve(to: CGPoint(x: rect.maxX - corner, y: rect.minY), control1: CGPoint(x: rect.maxX, y: rect.minY + corner / 2), control2: CGPoint(x: rect.maxX - corner / 2, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.minX + corner, y: rect.minY))
            path.addCurve(to: CGPoint(x: rect.minX, y: rect.minY + corner), control1: CGPoint(x: rect.minX + corner / 2, y: rect.minY), control2: CGPoint(x: rect.minX, y: rect.minY + corner / 2))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - corner))
            path.addCurve(to: CGPoint(x: rect.minX + corner, y: rect.maxY), control1: CGPoint(x: rect.minX, y: rect.maxY - corner / 2), control2: CGPoint(x: rect.minX + corner / 2, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.maxX - corner, y: rect.maxY))
            path.addCurve(to: CGPoint(x: rect.maxX, y: rect.maxY - corner), control1: CGPoint(x: rect.maxX - corner / 2, y: rect.maxY), control2: CGPoint(x: rect.maxX, y: rect.maxY - corner / 2))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - corner))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.closeSubpath()
            return path
        }
    }
    
    class func image(name: String, withExtension: String) -> CGPath? {
        if let url = Bundle.main.url(forResource: name, withExtension: withExtension),
            var bezierPath = SVGBezierPath.pathsFromSVG(at: url).first {
            bezierPath = bezierPath.settingSVGAttributes(["width": "100", "height": "100"])
            let path = bezierPath.cgPath
            let boundingBox = path.boundingBox
            // rotate & translate
            var transform = CGAffineTransform(rotationAngle: CGFloat.pi / 180 * 90)
            transform = transform.translatedBy(x: -boundingBox.midX, y: -boundingBox.midY)
            return path.copy(using: &transform)
        }
        return nil
    }
}
