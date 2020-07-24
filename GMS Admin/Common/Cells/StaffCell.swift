//
//  StaffCell.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class StaffCell: UITableViewCell {

    @IBOutlet var profPic: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var mail: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var statusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
