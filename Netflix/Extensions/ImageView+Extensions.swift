//
//  Image+Extensions.swift
//  Netflix
//
//  Created by Siddhant Mishra on 14/08/19.
//  Copyright © 2019 Siddhant Mishra. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        
        self.kf.setImage(with: URL(string: URLString))
    }
    
        var roundImage: UIImageView {
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
