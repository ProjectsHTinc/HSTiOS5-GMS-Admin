//
//  ReportStaffCell.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 25/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ReportStaffCell: UITableViewCell {

    @IBOutlet var userName: UILabel!
    @IBOutlet var total: UILabel!
    @IBOutlet var active: UILabel!
    @IBOutlet var inactive: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
