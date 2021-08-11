//
//  MeetingTabViewController.swift
//  Constituent
//
//  Created by HappysanziMac on 15/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingTabViewController: UIViewController {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var requested: UIView!
    @IBOutlet weak var completed: UIView!
    @IBOutlet weak var secheduled: UIView!
//    @IBOutlet var shadowNavView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requested.alpha  = 0
        completed.alpha   = 0
        secheduled.alpha   = 1
        segmentedControl.setTitle("Requested", forSegmentAt: 0)
        segmentedControl.setTitle("Sceduled", forSegmentAt: 1)
        segmentedControl.setTitle("Completed", forSegmentAt: 2)
//        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
//        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
//        segmentedControl.backgroundColor = UIColor.white
//        segmentedControl.tintColor = UIColor.white
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.black
            ], for: .normal)

        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 15) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.black
        ], for: .selected)
//        shadowNavView.layer.cornerRadius = 6
//        shadowNavView.layer.shadowColor = UIColor.darkGray.cgColor
//        shadowNavView.layer.shadowOpacity = 1.0
//        shadowNavView.layer.shadowOffset = CGSize.zero
//        shadowNavView.layer.shadowRadius = 3
    }
    
    @IBAction func segmentControllAction(_ sender: Any) {
        
    if (sender as AnyObject).selectedSegmentIndex == 0
    {
        requested.alpha  = 0
        completed.alpha   = 0
        secheduled.alpha   = 1
    }
    else if (sender as AnyObject).selectedSegmentIndex == 1
    {
        requested.alpha  = 0
        completed.alpha   = 1
        secheduled.alpha   = 0
    }
    else {
        requested.alpha  = 1
        completed.alpha   = 0
        secheduled.alpha   = 0
    }
  }
}
