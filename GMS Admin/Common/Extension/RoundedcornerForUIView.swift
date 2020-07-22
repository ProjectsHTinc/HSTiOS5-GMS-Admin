//
//  RoundedcornerForUIView.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 17/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

@IBDesignable class RoundedView: UIView {

@IBInspectable var cornerRadiusForUIView: CGFloat = 0.0
@IBInspectable var borderColorForUIView: UIColor = UIColor.black
@IBInspectable var borderWidthForUIView: CGFloat = 0.5
private var customBackgroundColor = UIColor.white
override var backgroundColor: UIColor?{
    didSet {
        customBackgroundColor = backgroundColor!
        super.backgroundColor = UIColor.clear
    }
}

func setup() {
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize.zero
    layer.shadowRadius = 5.0
    layer.shadowOpacity = 0.5
    super.backgroundColor = UIColor.clear
}

override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.setup()
}

override func draw(_ rect: CGRect) {
    customBackgroundColor.setFill()
    UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiusForUIView).fill()

    let borderRect = bounds.insetBy(dx: borderWidth/2, dy: borderWidth/2)
    let borderPath = UIBezierPath(roundedRect: borderRect, cornerRadius: cornerRadius - borderWidth/2)
    borderColorForUIView.setStroke()
    borderPath.lineWidth = borderWidth
    borderPath.stroke()

    // whatever else you need drawn
}
}
