//
//  UIImage+Extension.swift
//  ImageList
//
//  Created by Ivo Dutra on 04/08/20.
//  Copyright © 2020 Ivo Dutra. All rights reserved.
//

import UIKit

extension UIImage {
    struct Default {
        static let photoPlaceholder = UIImage(named: "placeholder")
    }

    /// Using view.layer.cornerRadius turns only background (the layer) with cornerRadius. An image from imageView needs to be also drawn with this.
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
       let maxRadius = min(size.width, size.height) / 2
       let cornerRadius: CGFloat

       if let radius = radius, radius > 0 && radius <= maxRadius {
           cornerRadius = radius
       } else {
           cornerRadius = maxRadius
       }

       UIGraphicsBeginImageContextWithOptions(size, false, scale)
       let rect = CGRect(origin: .zero, size: size)
       UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
       draw(in: rect)
       let image = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       return image
    }
}
