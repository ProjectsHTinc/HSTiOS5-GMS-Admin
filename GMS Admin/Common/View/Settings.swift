//
//  Settings.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 26/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SideMenu

class Settings: UIViewController,SideMenuNavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Settings"
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
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
           print("SideMenu Appearing! (animated: \(animated))")
        view.alpha = 0.8
       }

       func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
           print("SideMenu Appeared! (animated: \(animated))")
        
       }

       func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
           print("SideMenu Disappearing! (animated: \(animated))")
        view.alpha = 1
       }

       func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
           print("SideMenu Disappeared! (animated: \(animated))")
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
    
    @IBAction func editProfile(_ sender: Any) {
        self.performSegue(withIdentifier: "to_UserProfile", sender: self)
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
//        else if (segue.identifier == "to_sideMenu")
//        {
//            guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
//            sideMenuNavigationController.settings = makeSettings()
//        }
    }
    

}
