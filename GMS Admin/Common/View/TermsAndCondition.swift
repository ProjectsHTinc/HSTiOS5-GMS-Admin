//
//  TermsAndCondition.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class TermsAndCondition: UIViewController {
    
    var From = String()

    @IBOutlet var pagetitle: UILabel!
    @IBOutlet var desc: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (From == "terms"){
//            self.addCustomizedBackBtn(title:"  Terms And Condition")
            self.pagetitle.text = "Terms And Condition"
        }
        else{
//            self.addCustomizedBackBtn(title:"  Privacy Policy")
            self.pagetitle.text = "Privacy Policy"
        }
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
