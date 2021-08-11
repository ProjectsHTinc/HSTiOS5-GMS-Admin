//
//  MobileLogin.swift
//  GMS Admin
//
//  Created by HappysanziMac on 02/08/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class MobileLogin: UIViewController, UIPopoverPresentationControllerDelegate, ConstituencyListDelegate,MobileLoginView {
   
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var constituency: UITextField!
    @IBOutlet var constituencyOutlet: UIButton!
    
    let presenter = MobileLoginPresenter(loginService: MobileLoginService())

    override func viewDidLoad() {
      super.viewDidLoad()
     
        self.hideKeyboardWhenTappedAround()
        self.addCustomizedBackBtn(title:"")
    }
    
    @IBAction func loginAction(_ sender: Any){
        guard CheckValuesAreEmpty () else {
              return
        }
        callAPILogin ()
    }
    
    @IBAction func selectConstituent(_ sender: Any){
        
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        self.popOverButtonClick(sender: self.constituencyOutlet)
    }
    
    @IBAction func useMailIdAction(_ sender: Any) {
        
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    func callAPILogin ()
    {
        presenter.attachView(view: self)
        presenter.getLoginData(user_name: self.phoneNumber.text!,dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
    func popOverButtonClick (sender: UIButton)
    {
        let savingsInformationViewController = storyboard?.instantiateViewController(withIdentifier: "constituency") as! Constituency
            savingsInformationViewController.delegate = self
            savingsInformationViewController.strSaveText = self.constituency.text! as NSString
            savingsInformationViewController.modalPresentationStyle = .popover
        if let popoverController = savingsInformationViewController.popoverPresentationController {
            popoverController.sourceView = self.view
                popoverController.sourceRect = view.frame
                popoverController.permittedArrowDirections = .any
                popoverController.delegate = self
            }
        present(savingsInformationViewController, animated: true, completion: nil)
     }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle {
      return .none
    }

    private func presentationController(controller: UIPresentationController!, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController! {
        return UINavigationController(rootViewController: controller.presentedViewController)
    }
    
    func CheckValuesForConstituency () -> Bool
    {
        guard Reachability.isConnectedToNetwork() == true else{
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return false
        }
                 guard self.constituency.text?.count != 0  else {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: Globals.ConstituencyAlertMessage, complition: {
                
              })
             return false
         }
        return true

    }
    
    func CheckValuesAreEmpty () -> Bool{
        
        guard Reachability.isConnectedToNetwork() == true else{
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return false
        }
        
        guard self.constituency.text?.count != 0  else {
              AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: Globals.ConstituencyAlertMessage, complition: {
                
              })
              return false
         }
        
        guard self.phoneNumber.text?.count != 0  else {
              //self.email.showError()
              AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Phone Number is Empty", complition: {
              })
              return false
         }
        return true
    }
    
    func saveText(strText: String) {
        self.constituency.text = strText
    }
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func setLoginData(user_id: String, userImage: String, userName: String, userlocation: String) {
        
        self.performSegue(withIdentifier: "to_OTP", sender: self)
    }
    
    func setEmpty(errorMessage: String) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_OTP"){
            let vc = segue.destination as! OTPVc
//           vc.otp = sender as! String
           vc.mobileNumber = self.phoneNumber.text!.replacingOccurrences(of: " ", with: "")
        }
    }
}
