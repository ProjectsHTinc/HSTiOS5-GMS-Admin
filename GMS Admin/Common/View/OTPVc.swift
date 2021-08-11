//
//  OTPVc.swift
//  GMS Admin
//
//  Created by HappysanziMac on 19/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class OTPVc: UIViewController,OtpView {
  
//    @IBOutlet var activityView: UIActivityIndicatorView!
    @IBOutlet var textfiledOne: UITextField!
    @IBOutlet var textfieldTwo: UITextField!
    @IBOutlet var textfieldThree: UITextField!
    @IBOutlet var textfieldfour: UITextField!
    
    let presenterOtpService = OTPPresenter(oTPService: OTPService())
    var otpData = [OtpData]()
    var otp = String()
    var mobileNumber = String()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
       
    }
    
    @IBAction func verifyAction(_ sender: Any)
    {
        guard CheckValuesAreEmpty () else {
            return
        }
        
        self.otpSuccess ()
    }
    
    func CheckValuesAreEmpty () -> Bool{
        
        let attchedText = "\(textfiledOne.text ?? "")\(textfieldTwo.text ?? "")\(textfieldThree.text ?? "")\(textfieldfour.text ?? "")"

        guard Reachability.isConnectedToNetwork() == true else{
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
              })
              return false
        }
        
        guard self.textfiledOne.text?.count != 0 && self.textfieldTwo.text?.count != 0 && self.textfieldThree.text?.count != 0 && self.textfieldfour.text?.count != 0 else {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "empty", complition: {
                
              })
             return false
         }
        
        guard attchedText == self.otp else {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: Globals.OTPAlertMessage, complition: {
                
              })
             return false
         }
          return true
    }
    
    func otpSuccess ()
    {
        presenterOtpService.attachView(view: self)
        presenterOtpService.getOtpForOtpPage(mobile_no: self.mobileNumber, otp: self.otp,dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
    func startLoadingOtp() {
        
    }
    
    func finishLoadingOtp() {
        
    }
    
    func setOtp(otpValue: [OtpData]) {
        
    }
    
    func setEmptyOtp(errorMessage: String) {
        
    }
}
