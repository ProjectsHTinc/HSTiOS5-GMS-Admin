//
//  MeetingAllCell.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 22/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingAllCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var paguthi: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var createdBy: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
