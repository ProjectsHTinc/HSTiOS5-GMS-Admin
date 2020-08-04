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

extension UIView {

    func addGradient(colors: [UIColor], locations: [NSNumber]) {
        addSubview(ViewWithGradient(addTo: self, colors: colors, locations: locations))
    }
}

class ViewWithGradient: UIView {

    private var gradient = CAGradientLayer()

    init(addTo parentView: UIView, colors: [UIColor], locations: [NSNumber]){

        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 2))
        restorationIdentifier = "__ViewWithGradient"

        for subView in parentView.subviews {
            if let subView = subView as? ViewWithGradient {
                if subView.restorationIdentifier == restorationIdentifier {
                    subView.removeFromSuperview()
                    break
                }
            }
        }

        let cgColors = colors.map { (color) -> CGColor in
            return color.cgColor
        }

        gradient.frame = parentView.frame
        gradient.colors = cgColors
        gradient.locations = locations
        backgroundColor = .clear

        parentView.addSubview(self)
        parentView.layer.insertSublayer(gradient, at: 0)
        parentView.backgroundColor = .clear
        autoresizingMask = [.flexibleWidth, .flexibleHeight]

        clipsToBounds = true
        parentView.layer.masksToBounds = true

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if let parentView = superview {
            gradient.frame = parentView.bounds
        }
    }

    override func removeFromSuperview() {
        super.removeFromSuperview()
        gradient.removeFromSuperlayer()
    }
}
