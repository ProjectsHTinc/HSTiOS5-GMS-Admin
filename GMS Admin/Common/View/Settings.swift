//
//  Settings.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class Settings: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Settings"
        self.sideMenuButton()

    }
    
    @objc public override func sideMenuButtonClick()
    {
        self.performSegue(withIdentifier: "to_sideMenu", sender: self)
    }
    
    @IBAction func terms(_ sender: Any) {
        self.performSegue(withIdentifier: "to_terms", sender: "terms")
    }
    
    @IBAction func privacy(_ sender: Any) {
        self.performSegue(withIdentifier: "to_terms", sender: "privacy")
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_terms")
        {
           let vc = segue.destination as! TermsAndCondition
            vc.From = sender as! String
        }
    }
    

}
