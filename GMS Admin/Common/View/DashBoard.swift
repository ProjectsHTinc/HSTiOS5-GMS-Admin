//
//  DashBoard.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 06/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class DashBoard: UIViewController {

    @IBOutlet var searchText: TextFieldWithImage!
    @IBOutlet var area: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Removeing NavigationBar Bottom Line*/
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        /*Set delegate*/
        //self.searchText.delegate = self
        /*Set PlaceHolder textColor*/
        //area.attributedPlaceholder =
        //    NSAttributedString(string: "Select Area", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 188 / 255, green: 188 / 255, blue: 188 / 255, alpha: 1.0)])
        
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

extension DashBoard: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == searchText
        {
            if searchText.text?.isEmpty == true
            {
                AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Empty", complition: {
                    
                  })
            }
            else
            {
                self.performSegue(withIdentifier: "to_search", sender: self)
            }
        }
        return true
    }
}
