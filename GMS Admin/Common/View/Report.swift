//
//  Report.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 24/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SideMenu

class Report: UIViewController {
    
    var from = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Report"
        //setupSideMenu()
        self.sideMenuButton()

    }
    
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        
        //SideMenuPresentationStyle.menuSlideIn
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
    }
    
    func makeSettings() -> SideMenuSettings{
        var settings = SideMenuSettings()
        settings.allowPushOfSameClassTwice = false
        settings.presentationStyle = .menuSlideIn
        settings.presentationStyle.backgroundColor = .black
        settings.presentationStyle.presentingEndAlpha = 0.5
        settings.statusBarEndAlpha = 0
        return settings
    }
    
    @objc public override func sideMenuButtonClick()
    {
        self.performSegue(withIdentifier: "to_sideMenu", sender: self)
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
        self.performSegue(withIdentifier: "to_birthday", sender: self.from)
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
//        else if (segue.identifier == "to_sideMenu")
//        {
//            guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
//            sideMenuNavigationController.settings = makeSettings()
//        }
    }
    

}
