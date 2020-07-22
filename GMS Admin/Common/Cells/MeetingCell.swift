//
//  MeetingCell.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingCell: UITableViewCell {

    @IBOutlet var meetingTitle: UILabel!
    @IBOutlet var meetingdate: UILabel!
    @IBOutlet var meetingStatus: SideRoundedCornerLabel!
    @IBOutlet var titleImageGroup: UIImageView!
    @IBOutlet var calenderImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
