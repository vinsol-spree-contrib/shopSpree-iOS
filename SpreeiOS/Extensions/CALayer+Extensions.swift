//
//  CALayer+Extensions.swift
//  SpreeiOS
//
//  Created by Bharat Gupta on 31/08/16.
//  Copyright © 2016 Vinsol. All rights reserved.
//

import UIKit

extension CALayer {

    func addBorder(_ edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer();

        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness);
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}
