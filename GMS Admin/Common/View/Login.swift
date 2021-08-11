//
//  ViewController.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 27/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class Login: UIViewController  {
    
    var visioIsClicked = true

    @IBOutlet var constituency: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var hidePswrdOutlet: UIButton!
    @IBOutlet var constituencyOutlet: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    /*Get login Data */
    let presenter = LoginPresenter(loginService: LoginService())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*Set Delegate for Textfields*/
        self.email.delegate = self
        self.password.delegate = self
        /*Set PlaceHolder textColor*/
        constituency.attributedPlaceholder =
        NSAttributedString(string: "Select Constituency", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        /*Tap anywhere to hide keypad*/
        self.hideKeyboardWhenTappedAround()
        self.addCustomizedBackBtn(title:"")
//        view1.layer.cornerRadius = 6
//        view1.layer.shadowColor = UIColor.darkGray.cgColor
//        view1.layer.shadowOpacity = 0.5
//        view1.layer.shadowOffset = CGSize.zero
//        view1.layer.shadowRadius = 3
//
//        view2.layer.cornerRadius = 6
//        view2.layer.shadowColor = UIColor.darkGray.cgColor
//        view2.layer.shadowOpacity = 0.5
//        view2.layer.shadowOffset = CGSize.zero
//        view2.layer.shadowRadius = 3
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func selectConstituency(_ sender: Any){
        
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        self.popOverButtonClick(sender: self.constituencyOutlet)
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
    
    @IBAction func forgotPassword(_ sender: Any){
        
    }
    
    @IBAction func hidePassword(_ sender: Any) {
        
        if visioIsClicked == true {
            self.visioIsClicked = false
            self.hidePswrdOutlet.setImage(UIImage(named: "visionHide"), for: .normal)
            self.password.isSecureTextEntry = true
        }
        else{
            self.visioIsClicked = true
            self.hidePswrdOutlet.setImage(UIImage(named: "vision"), for: .normal)
            self.password.isSecureTextEntry = false
        }
    }
    
    @IBAction func go(_ sender: Any) {
              
        guard CheckValuesAreEmpty () else {
              return
        }
        self.callAPILogin()
              
    }
    
    @IBAction func forgotPassoword(_ sender: Any) {
        
//        guard CheckValuesForConstituency () else {
//              return
//        }
        
//        self.performSegue(withIdentifier: "to_fp", sender: self)
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
        
        guard self.email.text?.count != 0  else {
              //self.email.showError()
              AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Email / Phone Number is Empty", complition: {
              })
              return false
         }
        
        guard self.password.text?.count != 0  else {
              //self.password.showError()
              AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Password is Empty", complition: {
              })
              return false
         }
        
        guard self.password.text!.count >= 6  else {
              AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Short passwords are easy to guess!\nTry one with atleast 6 characters", complition: {
              })
              return false
         }
        
        return true
    }
    
    func callAPILogin ()
    {
        presenter.attachView(view: self)
        presenter.getLoginData(user_name: self.email.text!, password: self.password.text!,dynamic_db:GlobalVariables.shared.dynamic_db)
    }
}

extension Login : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if self.email.isFirstResponder
        {
            self.password.becomeFirstResponder()
        }
        else if self.password.isFirstResponder
        {
            self.password.resignFirstResponder()
        }
        
        return true
     }
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
     {
         if password.isFirstResponder
         {
             let maxLength = 12
             let currentString: NSString = password.text! as NSString
             let newString: NSString =
                 currentString.replacingCharacters(in: range, with: string) as NSString
             return newString.length <= maxLength
         }
         return true
     }
}

extension Login : UIPopoverPresentationControllerDelegate, ConstituencyListDelegate
{
     func saveText(strText: String) {
          self.constituency.text = strText
      }

      // MARK: - UIPopoverPresentationControllerDelegate
      func adaptivePresentationStyleForPresentationController(controller: UIPresentationController!) -> UIModalPresentationStyle {
        return .none
      }

    private func presentationController(controller: UIPresentationController!, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController! {
          return UINavigationController(rootViewController: controller.presentedViewController)
      }
}

extension Login : LoginView
{
    func startLoading() {
        //self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        //self.view.activityStopAnimating()
    }
    
    func setLoginData(user_id: String, userImage:String, userName:String, userlocation:String) {
         UserDefaults.standard.set(user_id, forKey: UserDefaultsKey.userIDkey.rawValue)
         UserDefaults.standard.set(userName, forKey: UserDefaultsKey.userNamekey.rawValue)
         UserDefaults.standard.set(userlocation, forKey: UserDefaultsKey.userLocationkey.rawValue)
         UserDefaults.standard.set(userImage, forKey: UserDefaultsKey.userImagekey.rawValue)
         //UserDefaults.standard.set(user_role, forKey: UserDefaultsKey.userRolekey.rawValue)
         GlobalVariables.shared.user_id = UserDefaults.standard.object(forKey: UserDefaultsKey.userIDkey.rawValue) as! String
         GlobalVariables.shared.user_Image = UserDefaults.standard.object(forKey: UserDefaultsKey.userImagekey.rawValue) as! String
         GlobalVariables.shared.user_name = UserDefaults.standard.object(forKey: UserDefaultsKey.userNamekey.rawValue) as! String
         GlobalVariables.shared.user_location = UserDefaults.standard.object(forKey: UserDefaultsKey.userLocationkey.rawValue) as! String
         //GlobalVariables.shared.user_role = UserDefaults.standard.object(forKey: UserDefaultsKey.userRolekey.rawValue) as! String
         self.performSegue(withIdentifier: "to_dashboard", sender: self)
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
//            self.dismiss(animated: false, completion: nil)
        })
    }
}
