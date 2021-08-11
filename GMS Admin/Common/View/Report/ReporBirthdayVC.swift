//
//  ReporBirthdayVC.swift
//  GMS Admin
//
//  Created by HappysanziMac on 01/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class ReporBirthdayVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,PaguthiView,OfficeView,ReportFestivalView, BirthdayYearView {
      
    @IBOutlet var pageTitle: UILabel!
    @IBOutlet var reportImageView: UIImageView!
    @IBOutlet var fromDate: TextFieldWithImage!
    @IBOutlet var toDate: TextFieldWithImage!
    @IBOutlet var month: TextFieldWithImage!
    @IBOutlet var paguthi: TextFieldWithImage!
    @IBOutlet var office: TextFieldWithImage!
      
      let presenter = PaguthiPresenter(areaService: AreaService())
      var paguthiData = [PaguthiData]()
      
      let presenterBirthdayYear = BirthdayYearPresenter(birthdayYearService: BirthdayYearService())
      var birthdayYearData = [BirthdayYearData]()
    
      let presenterOffice = OfficePresenter(officeService: OfficeService())
      var officeData = [OfficeData]()
    
      let datePicker = UIDatePicker()
      let pickerView = UIPickerView()
      
      var fromDateFormatted = String()
      var toDateFormatted = String()
      
      var selectedFromDate = Date()
      var selectedToDate = Date()
    
      var paguthiName = [String]()
      var paguthiId = [String]()
      var selectedPaguthuID  = String()
      
      var officeName = [String]()
      var officeId = [String]()
      var selectedofficeID  = String()
      var FestivalArr = [String]()
      var monthArr = [String]()
      var monthIdArr = [String]()
      var selectedMonthId = String()
      var from = String()
      var birtdayYearArr = [String]()
      var selectedBirtdayYear = String()
      var selectedfromYear = String()
      var selectedToYear = String()
         
      override func viewDidLoad() {
          super.viewDidLoad()
          
          self.hideKeyboardWhenTappedAround()
          self.pickerView.selectRow(0, inComponent: 0, animated: false)
          self.monthArr = ["January","Febraury","March","April","May","June","July","August","September","October","November","December"]
          self.monthIdArr = ["01","02","03","04","05","06","07","08","09","10","11","12"]
//          self.showDatePicker()
          self.createPickerView()
          guard Reachability.isConnectedToNetwork() == true else {
                AlertController.shared.offlineAlert(targetVc: self, complition: {
                  //Custom action code
               })
               return
          }
        self.callAPIOffice ()
        self.callAPIPaguthi()
        self.callAPIBirthdayYear ()
      }
      
      func callAPIPaguthi ()
      {
          presenter.attachView(view: self)
          presenter.getPaguthi(constituency_id: GlobalVariables.shared.constituent_Id, dynamic_db:GlobalVariables.shared.dynamic_db)
      }
      
      func callAPIOffice ()
      {
          presenterOffice.attachView(view: self)
          presenterOffice.getOffice(constituency_id: GlobalVariables.shared.constituent_Id, dynamic_db:GlobalVariables.shared.dynamic_db)
      }
    
    func callAPIBirthdayYear ()
    {
        presenterBirthdayYear.attachView(view: self)
        presenterBirthdayYear.getBirthdayYear(dynamic_db:GlobalVariables.shared.dynamic_db)
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
          
      @objc func cancelDatePicker(){
         self.view.endEditing(true)
       }
      
      func createPickerView() {
           pickerView.dataSource = self
           pickerView.delegate = self
           pickerView.backgroundColor = UIColor.white
           pickerView.setValue(UIColor.black, forKeyPath: "textColor")
         
           paguthi.inputView = pickerView
           office.inputView = pickerView
           month.inputView = pickerView
           fromDate.inputView = pickerView
           toDate.inputView = pickerView
        
           let toolBar = UIToolbar()
           toolBar.sizeToFit()
           let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
           let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
           let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))

           toolBar.setItems([cancelButton,spaceButton,doneButton], animated: true)
           toolBar.isUserInteractionEnabled = true
           toolBar.backgroundColor = UIColor.white
           toolBar.tintColor = UIColor(red: 45/255.0, green: 148/255.0, blue: 235/255.0, alpha: 1.0)
           paguthi.inputAccessoryView = toolBar
           office.inputAccessoryView = toolBar
           month.inputAccessoryView = toolBar
           fromDate.inputAccessoryView = toolBar
           toDate.inputAccessoryView = toolBar
      }
      
      func dismissPickerView() {

      }
      
      @objc func action() {
           let row = self.pickerView.selectedRow(inComponent: 0)
           self.pickerView.selectRow(row, inComponent: 0, animated: false)
          
        if self.paguthi.isFirstResponder{
           self.paguthi.text = self.paguthiName[row]
           self.selectedPaguthuID = self.paguthiId[row]
        }
        else if self.office.isFirstResponder{
          self.office.text = self.officeName[row]
          self.selectedofficeID = self.officeId[row]
        }
        else if self.month.isFirstResponder{
          self.month.text = self.monthArr[row]
          self.selectedMonthId = self.monthIdArr[row]
        }
        else if self.fromDate.isFirstResponder{
          self.fromDate.text = self.birtdayYearArr[row]
          self.selectedfromYear = self.birtdayYearArr[row]
        }
        else if self.toDate.isFirstResponder{
          self.toDate.text = self.birtdayYearArr[row]
          self.selectedToYear = self.birtdayYearArr[row]
        }

            view.endEditing(true)
      }
      
      @objc func cancel() {
            view.endEditing(true)
      }
      
      @IBAction func search(_ sender: Any)
      {
          guard CheckValuesAreEmpty () else {
                return
          }
        self.from = "birthday"
        self.performSegue(withIdentifier: "BirthDayList", sender: self.from)
  //            self.performSegue(withIdentifier: "to_reportMeeting", sender: self)
  //            self.performSegue(withIdentifier: "to_reportStaff", sender: self)
      }
    
    @IBAction func clearAction(_ sender: Any) {
        
        self.fromDate.text = ""
        self.toDate.text = ""
        self.paguthi.text = ""
        self.office.text = ""
    }
      
      func CheckValuesAreEmpty () -> Bool{
          
          let greater = selectedFromDate.timeIntervalSince1970 < selectedToDate.timeIntervalSince1970
        
              guard Reachability.isConnectedToNetwork() == true else{
                    AlertController.shared.offlineAlert(targetVc: self, complition: {
                      //Custom action code
                   })
                   return false
              }
              
              guard self.fromDate.text?.count != 0  else {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "From Date is Empty", complition: {
                      
                    })
                   return false
               }
              
              guard self.toDate.text?.count != 0  else {
                    AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To Date is Empty", complition: {
                        
                      })
                   return false
               }
              
//              guard greater == true  else {
//                    AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To date cannot be before start date", complition: {
//
//                      })
//                   return false
//               }
              
              guard self.paguthi.text?.count != 0  else {
                   AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Paguthi is Empty", complition: {
                        
                      })
                   return false
               }
          return true
      }
      
      func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }

      func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         
        if self.office.isFirstResponder
          {
              return self.officeName.count
          }
        else if paguthi.isFirstResponder
          {
              return self.paguthiName.count
          }
        else if month.isFirstResponder{
            return self.monthArr.count
        }
        else if fromDate.isFirstResponder{
            return self.birtdayYearArr.count
        }
        else {
            return self.birtdayYearArr.count
        }
      }

      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
              if office.isFirstResponder
              {
                  return self.officeName[row]
              }
              else if paguthi.isFirstResponder
              {
                  return self.paguthiName[row]
              }
              else if month.isFirstResponder{
                  return self.monthArr[row]
              }
              else if fromDate.isFirstResponder{
                  return self.birtdayYearArr[row]
              }
              else {
                  return self.birtdayYearArr[row]
              }
      }
      
      func startLoading(){
          self.view.activityStartAnimating()
      }
      
      func finishLoading(){
           self.view.activityStopAnimating()
      }
      
      func setPaguthi(paguthi: [PaguthiData]) {
           paguthiData = paguthi
           self.paguthiName.removeAll()
           self.paguthiId.removeAll()
           for items in paguthiData
           {
              let paguthi = items.paguthi_name
              let id = items.id
              self.paguthiName.append(paguthi.capitalized)
              self.paguthiId.append(id)
  //            pickerView.reloadAllComponents()
           }
           self.paguthiName.insert("ALL", at: 0)
           self.paguthiId.insert("ALL", at: 0)
      }
      
      func setoffice(office: [OfficeData]) {
          officeData = office
          self.officeName.removeAll()
          self.officeId.removeAll()
          for items in officeData
          {
             let office = items.office_name
              let id = items.id!
              self.officeName.append(office!.capitalized)
             self.officeId.append(id)
  //            pickerView.reloadAllComponents()
          }
          self.officeName.insert("ALL", at: 0)
          self.officeId.insert("ALL", at: 0)
      }
      
      func setEmpty(errorMessage: String) {
           AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
           })
      }
    
    func setFestival(festival: [ReportFestivalData]) {
        
    }
    
    func startLoadingSubCategoery() {
        
    }
    
    func finishLoadingSubCategoery() {
        
    }
    
    func setBirthdayYear(birthdayYear: [BirthdayYearData]) {
        birthdayYearData = birthdayYear
        self.birtdayYearArr.removeAll()
        
        for data in birthdayYearData {
            let year = data.year_name
            
            self.birtdayYearArr.append(year)
        }
    }
    
    func setEmptySubCategoery(errorMessage: String) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "BirthDayList")
        {
            let vc = segue.destination as! StatusReportList
            vc.from = sender as! String
            vc.paguthi = self.selectedPaguthuID
            vc.office = self.selectedofficeID
            vc.fromdate = selectedfromYear
            vc.todate = selectedToYear
            vc.month = selectedMonthId
        }
    }
}
