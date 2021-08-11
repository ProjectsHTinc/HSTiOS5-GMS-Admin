//
//  ConstituentListCell.swift
//  GMS Admin
//
//  Created by HappysanziMac on 05/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentListCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fatherName: UILabel!
    @IBOutlet weak var dob: UILabel!
//    @IBOutlet weak var problemlbl: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var mobNum: UILabel!
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
