//
//  WidgetVolounteer.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/12/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class WidgetVolounteer: UIViewController,VolounteerView {

    var paguthi_Id = String()
    let presenterTm = VolounteerPresenter(volounteerService: VolounteerService())
    
    @IBOutlet weak var volouinteerCount: UILabel!
    @IBOutlet weak var constituencyPercentage: UILabel!
    @IBOutlet weak var nonConstituencyPercentage: UILabel!
    @IBOutlet weak var constCount: UILabel!
    @IBOutlet weak var nonConstCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CallAPIVolunteer()
    }
    
    func CallAPIVolunteer ()
    {
        presenterTm.attachView(view: self)
        presenterTm.getVolounteer(paguthi: paguthi_Id, from_date: GlobalVariables.shared.widgetFromDate, to_date: GlobalVariables.shared.widgetToDate)
    }

    func startLoadingTm() {
//
    }
    
    func finishLoadingTm() {
//
    }
    
    func setTm(total_volunteer: String?, no_of_volunteer: String?, volunteer_percentage: String?, nonvolunteer_percentage: String?, no_of_nonvolunteer: String?) {
        
        volouinteerCount.text = total_volunteer
        constituencyPercentage.text = "Constituency(\(volunteer_percentage!)%)"
        nonConstituencyPercentage.text = nonvolunteer_percentage
        constCount.text = no_of_volunteer
        nonConstCount.text = no_of_nonvolunteer
        
    }
    
    func setEmptyTm(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }
    
    @IBAction func dissmissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
