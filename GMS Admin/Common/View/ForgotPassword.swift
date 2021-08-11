//
//  ForgotPassword.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 06/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ForgotPassword: UIViewController {

    let presenter = ForgotPasswordPresenter(forgotPasswordService: ForgotPasswordService())
    
    @IBOutlet var userName: UITextField!
    @IBOutlet weak var view1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*Set Delegate for Textfields*/
        self.userName.delegate = self
        /*Set Navigation Back Button*/
//        self.addCustomizedBackBtn(title:"")
        /*Tap anywhere to hide keypad*/
        self.hideKeyboardWhenTappedAround()
//        view1.layer.cornerRadius = 6
//        view1.layer.shadowColor = UIColor.darkGray.cgColor
//        view1.layer.shadowOpacity = 0.5
//        view1.layer.shadowOffset = CGSize.zero
//        view1.layer.shadowRadius = 3
    }
    
    @objc public override func backButtonClick()
    {
        self.performSegue(withIdentifier: "to_login", sender: self)
    }
    
    @IBAction func send(_ sender: Any)
    {
        guard CheckValuesAreEmpty () else {
              return
        }
        
        self.callAPIFp()
    }
    
    func CheckValuesAreEmpty () -> Bool{
        
        guard Reachability.isConnectedToNetwork() == true else{
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return false
        }
        
        guard self.userName.text?.count != 0  else {
              //self.userName.showError()
              AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Email / Phone Number is Empty", complition: {
              })
             return false
         }
        
          return true
    }
    
    func callAPIFp ()
    {
        presenter.attachView(view: self)
        presenter.getFpStatus(user_name: self.userName.text!)
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

extension ForgotPassword : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if self.userName.isFirstResponder
        {
            self.userName.resignFirstResponder()
        }

        return true
     }
}

extension ForgotPassword : ForgotPasswordView
{
    func startLoading() {
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        self.view.activityStopAnimating()
    }
    
    func setStatus(status: String,msg:String) {
        if status == "success"
        {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: msg, complition: {
                self.performSegue(withIdentifier: "to_login", sender: self)
            })
        }
    }
    
    func setEmpty(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            self.dismiss(animated: false, completion: nil)
        })
    }
}
