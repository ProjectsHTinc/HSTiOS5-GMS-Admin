//
//  SearchCell.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 07/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var username: UILabel!
    @IBOutlet var mobileNumber: UILabel!
    @IBOutlet var serialNumber: UILabel!
    @IBOutlet var mobile: UIImageView!
    @IBOutlet var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
