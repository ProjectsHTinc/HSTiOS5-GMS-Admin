//
//  ReportStaffVC.swift
//  GMS Admin
//
//  Created by HappysanziMac on 01/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class ReportStaffVC: UIViewController {
    
    @IBOutlet var pageTitle: UILabel!
    @IBOutlet var reportImageView: UIImageView!
    @IBOutlet var fromDate: TextFieldWithImage!
    @IBOutlet var toDate: TextFieldWithImage!
    
    let datePicker = UIDatePicker()
    var fromDateFormatted = String()
    var toDateFormatted = String()
    var selectedFromDate = Date()
    var selectedToDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.hideKeyboardWhenTappedAround()
        self.showDatePicker()
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
    }
    
    func showDatePicker(){
       //Formate Date
       datePicker.datePickerMode = .date
       datePicker.backgroundColor = UIColor.white
       datePicker.setValue(UIColor.black, forKeyPath: "textColor")
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
       //ToolBar
       let toolbar = UIToolbar();
       toolbar.sizeToFit()
       toolbar.backgroundColor = UIColor.white
       toolbar.tintColor = UIColor(red: 45/255.0, green: 148/255.0, blue: 235/255.0, alpha: 1.0)
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
       let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
       let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
       toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
       fromDate.inputAccessoryView = toolbar
       fromDate.inputView = datePicker
       toDate.inputAccessoryView = toolbar
       toDate.inputView = datePicker
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat = format

            return outputFormatter.string(from: date)
        }
        return nil
    }
    
    @IBAction func toList(_ sender: Any) {
        self.performSegue(withIdentifier: "toStaffList", sender: self)
    }
    
    @IBAction func clearAction(_ sender: Any) {
        
        self.fromDate.text = ""
        self.toDate.text = ""
     
    }
    
     @objc func donedatePicker(){
        if fromDate.isFirstResponder
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            fromDateFormatted = formatter.string(from: datePicker.date)
            selectedFromDate = datePicker.date
            let formatted = self.formattedDateFromString(dateString: fromDateFormatted, withFormat: "dd-MM-YYYY")
            fromDate.text = formatted
            self.view.endEditing(true)
        }
        else
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            toDateFormatted = formatter.string(from: datePicker.date)
            selectedToDate = datePicker.date
            let formatted = self.formattedDateFromString(dateString: toDateFormatted, withFormat: "dd-MM-YYYY")
            toDate.text = formatted
            self.view.endEditing(true)
        }
    }
        
    @objc func cancelDatePicker() {
       self.view.endEditing(true)
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "toStaffList")
        {
            let vc = segue.destination as! ReportStaffListVC
            vc.fromdate = self.fromDateFormatted
            vc.todate = self.toDateFormatted
        }
    }
}
