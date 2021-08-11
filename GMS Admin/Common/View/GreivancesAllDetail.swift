//
//  GreivancesAllDetail.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class GreivancesAllDetail: UIViewController {
    
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
    var id = String()

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
    
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        self.addCustomizedBackBtn(title:"  Grievance Details")
        self.place.text = _place
        self.seekerType.text = _seekerType
        self.petitionNumber.text = _petitionNumber
        self.refNumber.text = _refNumber
        self.greivanceName.text = _greivanceName
        self.subcat.text = _subcat
        self.desc.text = _desc
        let formatedCreated = self.formattedDateFromString(dateString: _createdon, withFormat: "dd-MM-YYYY")
        let formatedUpdatedOn = self.formattedDateFromString(dateString: _updatedOn, withFormat: "dd-MM-YYYY")
        self.createdon.text = formatedCreated
        self.updatedOn.text = formatedUpdatedOn
        self.status.text = _status
//        GlobalVariables.shared.constituent_Id = greivanceId
        
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
        backView.layer.cornerRadius = 6
        backView.layer.shadowColor = UIColor.darkGray.cgColor
        backView.layer.shadowOpacity = 0.5
        backView.layer.shadowOffset = CGSize.zero
        backView.layer.shadowRadius = 3
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
    
    @IBAction func messageHistory(_ sender: Any) {
        self.performSegue(withIdentifier: "to_messagePage", sender: self)
    }
    
    @IBAction func viewProfile(_ sender: Any) {
        GlobalVariables.shared.profGrivance = "GreiAll"
        self.performSegue(withIdentifier: "to_profilePage", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_messagePage"){
            let vc = segue.destination as! ConstituentGreivancesMessage
            vc.greivanceId = self.greivanceId
        }
        else if (segue.identifier == "to_profilePage"){
            let vc = segue.destination as! Profile
            vc.From = "GreiAll"
            vc.id = self.id
        }
    }
    

}
