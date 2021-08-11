//
//  CustomNavigationBarBackButtonWithTitle.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 18/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

extension UIViewController
{
    func addCustomizedBackBtn (title:String) {
            //Back buttion
            let btnLeftMenu: UIButton = UIButton()
            btnLeftMenu.setTitle(title, for: .normal)
            btnLeftMenu.setImage(UIImage(named: "back (2)"), for: UIControl.State())
            btnLeftMenu.addTarget(self, action: #selector(backButtonClick), for: UIControl.Event.touchUpInside)
            btnLeftMenu.frame = CGRect(x: 00, y: 0, width: 30, height: 30)
            let barButton = UIBarButtonItem(customView: btnLeftMenu)
            self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc public func backButtonClick()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addrightButton(bg_ImageName:String)
    {
        //Back buttion
        let btnRighttMenu: UIButton = UIButton()
        btnRighttMenu.setImage(UIImage(named: bg_ImageName), for: UIControl.State())
        btnRighttMenu.addTarget(self, action: #selector(rightButtonClick), for: UIControl.Event.touchUpInside)
        btnRighttMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: btnRighttMenu)
        self.navigationItem.rightBarButtonItem  = barButton
    }
    
    @objc public func rightButtonClick()
    {
        
    }
    
    func sideMenuButton()
    {
        //Back buttion
        let btnRighttMenu: UIButton = UIButton()
        btnRighttMenu.setImage(UIImage(named: "recent-2"), for: UIControl.State())
        btnRighttMenu.addTarget(self, action: #selector(sideMenuButtonClick), for: UIControl.Event.touchUpInside)
        btnRighttMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: btnRighttMenu)
        self.navigationItem.leftBarButtonItem  = barButton
    }
    
    @objc public func sideMenuButtonClick()
    {
        
    }
    
    func setLeftAlignedNavigationItemTitle(text: String,color: UIColor,margin left: CGFloat)
    {
        let titleLabel = UILabel()
        titleLabel.textColor = color
        titleLabel.text = text
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = titleLabel
        guard let containerView = self.navigationItem.titleView?.superview else { return }
        // NOTE: This always seems to be 0. Huh??
        let leftBarItemWidth = self.navigationItem.leftBarButtonItems?.reduce(0, { $0 + $1.width })
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,
                                             constant: (leftBarItemWidth ?? 0) + left),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
    }
}
    
