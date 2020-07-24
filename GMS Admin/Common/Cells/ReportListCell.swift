//
//  ReportListCell.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ReportListCell: UITableViewCell {
    
    @IBOutlet var pettionNumber: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet var subCategoeryName: UILabel!
    @IBOutlet var docName: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var mobile: UILabel!
    @IBOutlet var createdby: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
