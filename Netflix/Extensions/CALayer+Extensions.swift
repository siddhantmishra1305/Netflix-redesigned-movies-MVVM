//
//  CALayer+Extensions.swift
//  Netflix
//
//  Created by Siddhant Mishra on 19/08/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import Foundation
import UIKit


extension CALayer{
    func giveShadowToTableViewCell(layer:CALayer,Bounds:CGRect , cornerRadius:CFloat) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: Bounds, cornerRadius: 0.0).cgPath
    }
}

extension UIView{
    var roundedImage: UIView {
        let curvedPercent = 0.15 as CGFloat
        let maskLayer = CAShapeLayer(layer: self.layer)
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x:0, y:0))
        arrowPath.addLine(to: CGPoint(x:self.bounds.size.width, y:0))
        arrowPath.addLine(to: CGPoint(x:self.bounds.size.width, y:self.bounds.size.height - (self.bounds.size.height * curvedPercent)))
        arrowPath.addQuadCurve(to: CGPoint(x:0, y:self.bounds.size.height - (self.bounds.size.height * curvedPercent)), controlPoint: CGPoint(x:self.bounds.size.width/2, y:self.bounds.size.height))
        arrowPath.addLine(to: CGPoint(x:0, y:0))
        arrowPath.close()
        
        maskLayer.path = arrowPath.cgPath
        maskLayer.frame = self.bounds
        maskLayer.masksToBounds = true
        self.layer.mask = maskLayer
        return self
    }
}
