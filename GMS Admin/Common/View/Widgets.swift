//
//  Widgets.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 10/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class Widgets: UIViewController,ConstituentMemberView {
    
    
    @IBOutlet weak var consCount: UILabel!
    @IBOutlet weak var malePercentage: UILabel!
    @IBOutlet weak var femalePercentage: UILabel!
    @IBOutlet weak var transgenPercentage: UILabel!
    @IBOutlet weak var phoneNoPercentage: UILabel!
    @IBOutlet weak var whatsupPercentage: UILabel!
    @IBOutlet weak var whatsapBroadcastPercentage: UILabel!
    @IBOutlet weak var emailidPercentage: UILabel!
    @IBOutlet weak var voterIdPercentage: UILabel!
    @IBOutlet weak var DOBPercentage: UILabel!
    @IBOutlet weak var maleCount: UILabel!
    @IBOutlet weak var femaleCount: UILabel!
    @IBOutlet weak var transgenCount: UILabel!
    @IBOutlet weak var phoneNoCount: UILabel!
    @IBOutlet weak var whatsapCount: UILabel!
    @IBOutlet weak var whatsapBroadCastCount: UILabel!
    @IBOutlet weak var emailIdCount: UILabel!
    @IBOutlet weak var voterIdCount: UILabel!
    @IBOutlet weak var dobCount: UILabel!
    
    
    
    let presenter = ConstituentMemberPresenter(constituentMemberService: ConstituentMemberService())
    var CMData = [ConstituentMemberData]()
    var paguthi_Id = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        self.callAPICI()
        
    }
    
    func callAPICI ()
    {
        presenter.attachView(view: self)
        presenter.getTotalGreviances(paguthi: paguthi_Id, from_date: GlobalVariables.shared.widgetFromDate, to_date: GlobalVariables.shared.widgetToDate)
    }
    
    
    func startLoadingCi() {
//
    }
    
    func finishLoadingCI() {
//
    }
    
    func setCI(constituentMemberData: [ConstituentMemberData]) {
        
        for datas in constituentMemberData {
            consCount.text = ("Constituent Count (\(datas.total!)%)")
            malePercentage.text = ("Male (\(datas.malecount!)%)")
            femalePercentage.text = ("Female (\(datas.femalepercenatge!)%)")
            transgenPercentage.text = ("Transgender (\(datas.otherpercenatge!)%)")
            phoneNoPercentage.text = ("Havinge Phone no (\(datas.mobile_percentage!)%)")
            whatsupPercentage.text = ("Having Whatsap (\(datas.whatsapp_percentage!)%)")
            whatsapBroadcastPercentage.text = ("Whatsap Broadcast (\(datas.broadcast_percentage!)%)")
            emailidPercentage.text = ("Having EmailId (\(datas.email_percentage!)%)")
            voterIdPercentage.text = ("Having VoterId (\(datas.having_voter_percenatge!)%)")
            DOBPercentage.text = (" DOB Updated (\(datas.having_dob_percentage!)%)")
            maleCount.text = datas.malecount
            femaleCount.text = datas.femalecount
            transgenCount.text = datas.others
            phoneNoCount.text = datas.having_mobilenumber
            whatsapCount.text = datas.having_whatsapp
            whatsapBroadCastCount.text = datas.having_whatsapp_broadcast
            emailIdCount.text = datas.having_email
            voterIdCount.text = datas.having_vote_id
            dobCount.text = datas.having_dob
         
          }
    }
    
    func setEmptyCI(errorMessage: String) {
//
    }
    
    @IBAction func dissmissAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
