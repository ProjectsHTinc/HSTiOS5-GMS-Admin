//
//  ChangePassword.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ChangePassword: UIViewController {

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
    }
    
    @IBAction func currentPswrdVision(_ sender: Any) {
    }
    
    @IBAction func newPswrdVision(_ sender: Any) {
    }
    
    @IBAction func confirmPswrdVision(_ sender: Any) {
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
