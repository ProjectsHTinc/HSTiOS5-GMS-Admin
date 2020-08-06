//
//  ConstituentGreivancesDetail.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 21/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentGreivancesDetail: UIViewController {
    
    var _place = String()
    var _seekerType = String()
    var _petitionNumber = String()
    var _refNumber = String()
    var _greivanceName = String()
    var _subcat = String()
    var _desc = String()
    var _createdon = String()
    var _updatedOn = String()
    var _status = String()
    var greivanceId = String()
    var type = String()

    @IBOutlet var place: UILabel!
    @IBOutlet var seekerType: UILabel!
    @IBOutlet var petitionNumber: UILabel!
    @IBOutlet var refNumber: UILabel!
    @IBOutlet var greivanceName: UILabel!
    @IBOutlet var subcat: UILabel!
    @IBOutlet var desc: UILabel!
    @IBOutlet var createdon: UILabel!
    @IBOutlet var updatedOn: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var statusBgView: UIView!
    @IBOutlet var petitionTitleLabel: UILabel!
    @IBOutlet var descripitionTitleLabel: UILabel!
    @IBOutlet var descripitionBaseLabel: UILabel!
    @IBOutlet var descripitionTitleHeight: NSLayoutConstraint!
    @IBOutlet var descHeight: UILabel!
    @IBOutlet var descripitionBaseHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.place.text = _place.capitalized
        self.seekerType.text = _seekerType.capitalized
        self.petitionNumber.text = _petitionNumber
        self.refNumber.text = _refNumber
        self.greivanceName.text = _greivanceName.capitalized
        self.subcat.text = _subcat.capitalized
        self.desc.text = _desc.capitalized
        let formatedCreated = self.formattedDateFromString(dateString: _createdon, withFormat: "dd-MM-YYYY")
        let formatedUpdatedOn = self.formattedDateFromString(dateString: _updatedOn, withFormat: "dd-MM-YYYY")
        self.createdon.text = formatedCreated
        self.updatedOn.text = formatedUpdatedOn
        self.status.text = _status.capitalized
        
        if (type == "P")
        {
            self.petitionTitleLabel.text = "Petition Number"
            self.descripitionTitleLabel.isHidden = false
            self.descripitionBaseLabel.isHidden = false
        }
        else
        {
            self.petitionTitleLabel.text = "Enquiry Number"
            self.descripitionTitleLabel.isHidden = true
            self.descripitionBaseLabel.isHidden = true
            self.descripitionBaseHeight.constant = 0
            self.descripitionTitleHeight.constant = 0
        }
        
        if (self.status.text == "Processing")
        {
            self.status.backgroundColor = UIColor(red: 253/255, green: 166/255, blue: 68/255, alpha: 1.0)
            self.status.layer.cornerRadius = 4.0
            self.status.clipsToBounds = true
        }
        else
        {
            self.status.backgroundColor = UIColor(red: 112/255, green: 173/255, blue: 71/255, alpha: 1.0)
            self.status.layer.cornerRadius = 4.0
            self.status.clipsToBounds = true
        }

        self.addCustomizedBackBtn(title:"  Grievance detail")

    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format

            return outputFormatter.string(from: date)
        }

        return nil
    }
    

    @IBAction func messageAction(_ sender: Any)
    {
        self.performSegue(withIdentifier: "to_consGreMessage", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_consGreMessage"){
            let vc = segue.destination as! ConstituentGreivancesMessage
            vc.greivanceId = greivanceId
        }
    }
    

}
