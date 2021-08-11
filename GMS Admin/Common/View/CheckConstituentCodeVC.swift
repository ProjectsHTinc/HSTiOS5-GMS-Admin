//
//  CheckConstituentCodeVC.swift
//  GMS Admin
//
//  Created by HappysanziMac on 19/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class CheckConstituentCodeVC: UIViewController,CheckConstituentView {

    @IBOutlet weak var constituentCodeTextField: UITextField!
    @IBOutlet weak var constituentView: UITextField!
    @IBOutlet weak var getStartOutlet: UIButton!
    @IBOutlet weak var textFieldView: UIView!
    
    let presenter = CheckConstituentPresenter(checkConstituentService: CheckConstituentService())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
    
//        textFieldView.layer.cornerRadius = 6
//        textFieldView.layer.shadowColor = UIColor.darkGray.cgColor
//        textFieldView.layer.shadowOpacity = 0.5
//        textFieldView.layer.shadowOffset = CGSize.zero
//        textFieldView.layer.shadowRadius = 3
    }
    
    @IBAction func getStartedAction(_ sender: Any) {
        
        if constituentCodeTextField.text!.count == 0 {
            
        }
        else {
            presenter.attachView(view: self)
            presenter.getLoginData(constituency_code:constituentCodeTextField.text!)
        }
    }
    
    func startLoading(){
        
    }
    
    func finishLoading(){
        
    }
    
    func setConstituency(constituencyname: [CheckConstituentData]){
        
        self.performSegue(withIdentifier: "to_login", sender: self)
        
    }
}
