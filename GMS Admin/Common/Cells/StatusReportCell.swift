//
//  StatusReportCell.swift
//  GMS Admin
//
//  Created by HappysanziMac on 12/08/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class StatusReportCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var fatherName: UILabel!
    @IBOutlet var mobNum: UILabel!
    @IBOutlet var dob: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        backView.layer.cornerRadius = 6
        backView.layer.shadowColor = UIColor.darkGray.cgColor
        backView.layer.shadowOpacity = 0.5
        backView.layer.shadowOffset = CGSize.zero
        backView.layer.shadowRadius = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
