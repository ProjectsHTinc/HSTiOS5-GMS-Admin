//
//  Report.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class Report: UIViewController {
    
    var from = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func status(_ sender: Any) {
        self.from = "status"
        self.performSegue(withIdentifier: "to_reportStatus", sender: self.from)
    }
    
    @IBAction func categoery(_ sender: Any) {
        self.from = "categoery"
        self.performSegue(withIdentifier: "to_reportStatus", sender: self.from)
    }
    
    @IBAction func subcategoery(_ sender: Any) {
        self.from = "subCate"
        self.performSegue(withIdentifier: "to_reportStatus", sender: self.from)
    }
    
    @IBAction func location(_ sender: Any) {
        self.from = "location"
        self.performSegue(withIdentifier: "to_reportStatus", sender: self.from)
    }
    
    @IBAction func meeting(_ sender: Any) {
        self.from = "meeting"
        self.performSegue(withIdentifier: "to_reportStatus", sender: self.from)
    }
    
    @IBAction func staff(_ sender: Any) {
        self.from = "staff"
        self.performSegue(withIdentifier: "to_reportStatus", sender: self.from)
    }
    
    @IBAction func birthday(_ sender: Any) {
        self.performSegue(withIdentifier: "to_reportStatus", sender: self.from)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_reportStatus")
        {
            let vc = segue.destination as! ReportStatus
            vc.from = sender as! String
        }
    }
    

}
