//
//  ChangePassword.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ChangePassword: UIViewController {
    
    /*Get User Details List*/
    let presenter = ChangePasswordPresenter(changePasswordService:ChangePasswordService())
    var changepasswordData = [ChangePasswordData]()
    
    var curentVisioIsClicked = true
    var newVisioIsClicked = true
    var confirmVisioIsClicked = true

    @IBOutlet var currentPassword: UITextField!
    @IBOutlet var newPassword: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var curentPswrdVisionOutlet: UIButton!
    @IBOutlet var newPswrdVisionOutlet: UIButton!
    @IBOutlet var confirmPswrdVisionOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        guard CheckValuesAreEmpty () else {
              return
        }
        
        self.callAPI(current: currentPassword.text!, new: newPassword.text!, confirm: confirmPassword.text!)
    }
    
    @IBAction func currentPswrdVision(_ sender: Any) {
        if curentVisioIsClicked == true{
            self.curentVisioIsClicked = false
            self.curentPswrdVisionOutlet.setImage(UIImage(named: "visionHide"), for: .selected)
            self.currentPassword.isSecureTextEntry = true
        }
        else{
            self.curentVisioIsClicked = true
            self.curentPswrdVisionOutlet.setImage(UIImage(named: "vision"), for: .selected)
            self.currentPassword.isSecureTextEntry = false
        }
    }
    
    @IBAction func newPswrdVision(_ sender: Any) {
        if confirmVisioIsClicked == true{
            self.confirmVisioIsClicked = false
            self.curentPswrdVisionOutlet.setImage(UIImage(named: "visionHide"), for: .selected)
            self.newPassword.isSecureTextEntry = true

        }
        else{
            self.confirmVisioIsClicked = true
            self.curentPswrdVisionOutlet.setImage(UIImage(named: "vision"), for: .selected)
            self.newPassword.isSecureTextEntry = false
        }
    }
    
    @IBAction func confirmPswrdVision(_ sender: Any) {
        if curentVisioIsClicked == true{
            self.curentVisioIsClicked = false
            self.curentPswrdVisionOutlet.setImage(UIImage(named: "visionHide"), for: .selected)
            self.confirmPassword.isSecureTextEntry = true

        }
        else{
            self.curentVisioIsClicked = true
            self.curentPswrdVisionOutlet.setImage(UIImage(named: "vision"), for: .selected)
            self.confirmPassword.isSecureTextEntry = false

        }
    }
    
    func CheckValuesAreEmpty () -> Bool{
        
        guard Reachability.isConnectedToNetwork() == true else{
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return false
        }
        
        guard self.currentPassword.text?.count != 0  else {
              AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Current Password is Empty", complition: {
                
              })
             return false
         }
        
        guard self.newPassword.text?.count != 0  else {
              AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "New Password is Empty", complition: {
                  
                })
             return false
         }
        
        guard self.confirmPassword.text?.count != 0  else {
              AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Confirm Password is Empty", complition: {
                  
                })
             return false
         }
        
        guard self.newPassword.text == self.confirmPassword.text  else {
              AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Password Mismatch", complition: {
                  
                })
             return false
         }
        
        
          return true
    }
    
    func callAPI(current:String,new:String,confirm:String){
        presenter.attachView(view: self)
        presenter.getChangePassword(user_id: GlobalVariables.shared.user_id, new_password: new, old_password: current)
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

extension ChangePassword : ChangePasswordView{
    func startLoading() {
         //
    }
    
    func finishLoading() {
         //
    }
    
    func setChangePassword(msg: String, status: String) {
         if  status == "Success"{
             AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: msg, complition: {
                self.navigationController?.popViewController(animated: true)
             })
         }
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
    }
    
    
}
