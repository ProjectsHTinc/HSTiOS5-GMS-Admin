//
//  ConstituentGreivancesCell.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 20/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentGreivancesCell: UITableViewCell {

    @IBOutlet var pettionNumber: UILabel!
    @IBOutlet var greivanesType: UILabel!
    @IBOutlet var greivanceName: UILabel!
    @IBOutlet var subCategoeryName: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var statusBgView: SideRoundedCornerView!
    @IBOutlet var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
