//
//  GradientColors.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 13/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class GradientBackgroundView {
    
    var gl:CAGradientLayer!

    let colorTop = UIColor(red: 45.0 / 255.0, green: 148.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0).cgColor
    let colorBottom = UIColor(red: 23.0 / 255.0, green: 74.0 / 255.0, blue: 118.0 / 255.0, alpha: 1.0).cgColor

    init() {
     self.gl = CAGradientLayer()
     self.gl.colors = [colorTop, colorBottom]
     self.gl.startPoint = CGPoint(x: 0.5, y: 0)
     self.gl.endPoint = CGPoint(x: 0.5, y: 1.0)
    }

}
