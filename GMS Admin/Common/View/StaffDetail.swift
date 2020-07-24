//
//  StaffDetail.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 23/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class StaffDetail: UIViewController, StaffDetailView {

    /*Get Staff Detail List*/
    let presenter = StaffDetailPresenter(staffDetailService: StaffDetailService())
    var data = [StaffDetailData]()
    
    var staffId = String()

    @IBOutlet var userImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var status: UILabel!
    @IBOutlet var statusView: UIView!
    @IBOutlet var role: UILabel!
    @IBOutlet var gender: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var address: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        self.callAPIStaffDetail ()
    }
    
    func callAPIStaffDetail ()
    {
        presenter.attachView(view: self)
        presenter.getStaffDetail(staff_id: staffId)
    }
    
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setStaffDetail(staffdetail: [StaffDetailData]) {
         data = staffdetail
        self.userImage.sd_setImage(with: URL(string: Globals.userImgUrl + data[0].profile_pic), placeholderImage: UIImage(named: "PhUserImage.png"))
        self.name.text = data[0].full_name
        self.email.text = data[0].email_id
        self.location.text = data[0].paguthi_name
        self.status.text = data[0].status
        self.role.text = data[0].role_name
        self.gender.text = data[0].gender
        self.phone.text = data[0].phone_number
        self.address.text = data[0].address
        
        if self.status.text == "ACTIVE"{
            self.status.textColor = UIColor(red: 106/255, green: 168/255, blue: 79/255, alpha: 1.0)
            self.statusView.backgroundColor = UIColor(red: 106/255, green: 168/255, blue: 79/255, alpha: 1.0)
        }
        else{
            self.status.textColor = UIColor(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0)
            self.statusView.backgroundColor = UIColor(red: 204/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }

    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
