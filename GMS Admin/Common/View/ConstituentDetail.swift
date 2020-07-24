//
//  ConstituentDetail.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 13/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SDWebImage

class ConstituentDetail: UIViewController {

    /*Get login Data */
    let presenter = ConstituentDetailPresenter(constituentDetailService: ConstituentDetailService())
    var constituentdetail = [ConstituentDetailData]()

    
    let colors = GradientBackgroundView()

    @IBOutlet var constituentImage: UIImageView!
    @IBOutlet var gradientView: UIView!
    @IBOutlet var name: UILabel!
    @IBOutlet var mobileNumber: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var wardNumber: UILabel!
    @IBOutlet var serialNumber: UILabel!
    @IBOutlet var voterID: UILabel!
    @IBOutlet var adharNumber: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Removeing NavigationBar Bottom Line*/
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        /*Set Gradient View*/
        self.setGradientBackGroundView()
        
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        
        self.callAPIConstituentDetail()
    }
    
    func setGradientBackGroundView (){
        
        gradientView.backgroundColor = UIColor.white
        let backgroundLayer = colors.gl
        backgroundLayer!.frame = gradientView.frame
        gradientView.layer.insertSublayer(backgroundLayer!, at: 0)
        
    }
    
    func callAPIConstituentDetail ()
    {
        presenter.attachView(view: self)
        presenter.getConstituentDetailData(constituent_id: GlobalVariables.shared.constituent_Id)
    }
    
    @IBAction func meeting(_ sender: Any) {
        self.performSegue(withIdentifier: "to_meeting", sender: self)
    }
    
    @IBAction func greivances(_ sender: Any) {
        self.performSegue(withIdentifier: "to_ConstituentGre", sender: self)
    }
    
    @IBAction func interaction(_ sender: Any) {
        self.performSegue(withIdentifier: "to_interaction", sender: self)
    }
    
    @IBAction func plants(_ sender: Any) {
        self.performSegue(withIdentifier: "to_plantDonation", sender: self)
    }
    
    @IBAction func documents(_ sender: Any) {
        self.performSegue(withIdentifier: "to_doc", sender: self)
    }
    
    @IBAction func profile(_ sender: Any) {
        self.performSegue(withIdentifier: "to_ConsProfile", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_meeting")
        {
            let vc = segue.destination as! Meeting
            vc.From = "Cd"
        }
        else if (segue.identifier == "to_plantDonation")
        {
            _ = segue.destination as! PlantDonation
        }
    }
    

}

extension ConstituentDetail: ConstituentDetailView{
    func startLoading() {
        //
    }
    
    func finishLoading() {
        //
    }
    
    func setConstituentDetailData(constituentDetail: [ConstituentDetailData]) {
         constituentdetail = constituentDetail
        self.name.text = constituentdetail[0].full_name
        self.mobileNumber.text = constituentdetail[0].mobile_no
        self.location.text = constituentdetail[0].address
        self.wardNumber.text = constituentdetail[0].ward_id
        self.serialNumber.text = constituentdetail[0].id
        self.voterID.text = constituentdetail[0].voter_id_no
        self.adharNumber.text = constituentdetail[0].aadhaar_no
        self.constituentImage.sd_setImage(with: URL(string: Globals.imageUrl + constituentdetail[0].profile_pic), placeholderImage: UIImage(named: "PhUserImage.png"))
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         //self.dismiss(animated: false, completion: nil)
         })
    }
    
    
    
}
