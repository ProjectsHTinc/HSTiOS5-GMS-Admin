//
//  RequestedCell.swift
//  Constituent
//
//  Created by HappysanziMac on 15/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class RequestedCell: UITableViewCell {
    
    @IBOutlet var meetingTitle: UILabel!
    @IBOutlet var meetingdate: UILabel!
//    @IBOutlet var meetingStatus: SideRoundedCornerLabel!
//    @IBOutlet var titleImageGroup: UIImageView
    @IBOutlet var backView: UIView!
    @IBOutlet var cretaeDate: UILabel!
//    @IBOutlet var meetingOnDate: UILabel!
    
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

    }
}
