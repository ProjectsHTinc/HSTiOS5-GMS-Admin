//
//  DashBoard.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 06/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Charts

class DashBoard: UIViewController, ChartViewDelegate {

    @IBOutlet var searchText: TextFieldWithImage!
    @IBOutlet var area: UITextField!
    @IBOutlet var constituentlabel: UILabel!
    @IBOutlet var meetingLabel: UILabel!
    @IBOutlet var grievanceLabel: UILabel!
    @IBOutlet var interactionLabel: UILabel!
    @IBOutlet var barchart: BarChartView!
    
    
    /*Get Paguthi List*/
    let presenter = PaguthiPresenter(areaService: AreaService())
    var paguthiData = [PaguthiData]()
    var paguthiName = [String]()
    var paguthiId = [String]()
    let pickerView = UIPickerView()

//    var selctedPaguthiId = String ()
    
    var dispMonth = [String]()
    var new_grev = [Double]()
    var repeeated_grev = [Double]()
    var total = [String]()
    var grivenacegraph = [Double]()
    var meeting_request = [Double]()
    var month_year = [String]()

    var to = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Removeing NavigationBar Bottom Line*/
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        /*Set delegate*/
        self.searchText.delegate = self
        self.area.delegate = self
        /*Set PlaceHolder textColor*/
        area.attributedPlaceholder =
        NSAttributedString(string: "Select Area", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 188 / 255, green: 188 / 255, blue: 188 / 255, alpha: 1.0)])
        //areaView.dropShadow()
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        self.createPickerView()
        GlobalVariables.shared.selectedPaguthiId = "ALL"
        GlobalVariables.shared.sideMenuDropdown =  "false"
        self.callAPI(paguthi:GlobalVariables.shared.selectedPaguthiId)
        setupView()
        /*Tap anywhere to hide keypad*/
        self.hideKeyboardWhenTappedAround()
    }
    

    func callAPIPaguthi ()
    {
        presenter.attachView(view: self)
        presenter.getPaguthi(constituency_id: GlobalVariables.shared.constituent_Id)
    }
    
    func createPickerView() {
         pickerView.dataSource = self
         pickerView.delegate = self
         pickerView.backgroundColor = UIColor.white
         pickerView.setValue(UIColor.black, forKeyPath: "textColor")
        
         let toolBar = UIToolbar()
         toolBar.sizeToFit()
         let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
         let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
         let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))

         toolBar.setItems([cancelButton,spaceButton,doneButton], animated: true)
         toolBar.isUserInteractionEnabled = true
         toolBar.barTintColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 248/255.0, alpha: 1.0)
         toolBar.tintColor = UIColor(red: 45/255.0, green: 148/255.0, blue: 235/255.0, alpha: 1.0)
         toolBar.isUserInteractionEnabled = true
         toolBar.isTranslucent = true
         area.inputView = pickerView
         area.inputAccessoryView = toolBar
    }
    
    
    @objc func action() {
          let row = self.pickerView.selectedRow(inComponent: 0)
          self.pickerView.selectRow(row, inComponent: 0, animated: false)
          if self.area.isFirstResponder{
             area.text = self.paguthiName[row]// selected item
             GlobalVariables.shared.selectedPaguthiId = self.paguthiId[row]
          }
          self.callAPI(paguthi:GlobalVariables.shared.selectedPaguthiId)
          self.area.resignFirstResponder()
          view.endEditing(true)
    }
    
    @objc func cancel() {
          view.endEditing(true)
    }
    
    func callAPI (paguthi:String)
    {
        let url = GlobalVariables.shared.CLIENTURL + "apiios/dashBoard/"
        let parameters = ["paguthi": paguthi]
        self.view.activityStartAnimating()
        DispatchQueue.global().async
            {
                do
                {
                    try AFWrapper.requestPOSTURL(url, params: (parameters), headers: nil, success: {
                        (JSONResponse) -> Void in
                        self.view.activityStopAnimating()
                        print(JSONResponse)
                        let json = JSON(JSONResponse)
                        let msg = json["msg"].stringValue
                        let status = json["status"].stringValue
                        if msg == "Dashboard Details" && status == "Success"
                        {
                            self.constituentlabel.text = json["widgets_count"]["constituent_count"].stringValue
                            self.meetingLabel.text = json["widgets_count"]["meeting_count"].stringValue
                            self.grievanceLabel.text = json["widgets_count"]["grievance_count"].stringValue
                            self.interactionLabel.text = json["widgets_count"]["interaction_count"].stringValue
                            
                            GlobalVariables.shared.constituent_MemberCount = self.constituentlabel.text!
                            GlobalVariables.shared.totalMeetingsCount = self.meetingLabel.text!
                            GlobalVariables.shared.totalGrievancesCount = self.grievanceLabel.text!
                            //GlobalVariables.shared.interActionCount = self.interactionLabel.text!
                            GlobalVariables.shared.constituentInteractionCount = self.interactionLabel.text!

                            self.dispMonth.removeAll()
                            self.new_grev.removeAll()
                            self.repeeated_grev.removeAll()
                            self.grivenacegraph.removeAll()
                            self.meeting_request.removeAll()
                            self.month_year.removeAll()
                            /*Bar Chart*/
                            let footFall = json["footfall_graph"]
                            for i in 0..<(footFall.count)
                            {
                                let dict = footFall[i]
                                let dispMonth = dict["disp_month"].string
                                let newGrev = dict["new_grev"].double
                                let repeatedGrev = dict["repeated_grev"].double
                                //let _total = dict["total"].string

                                self.dispMonth.append(dispMonth!)
                                self.new_grev.append(newGrev!)
                                self.repeeated_grev.append(repeatedGrev!)
                                //self.total.append(_total!)
                            }
                            self.setupView()
                            /*Pie Chart*/
                            let gerv_ecount = json["grievance_graph"]["gerv_ecount"].doubleValue
                            let gerv_ppcount = json["grievance_graph"]["gerv_ppcount"].doubleValue
                            let gerv_pccount = json["grievance_graph"]["gerv_pccount"].doubleValue

                            self.grivenacegraph.insert(gerv_ecount, at: 0)
                            self.grivenacegraph.insert(gerv_ppcount, at: 1)
                            self.grivenacegraph.insert(gerv_pccount, at: 2)

                            let meeting_graph = json["meeting_graph"]
                            for i in 0..<(meeting_graph.count)
                            {
                                let dict = meeting_graph[i]
                                let meetingrequest = dict["meeting_request"].doubleValue
                                let monthyear = dict["month_year"].string

                                self.meeting_request.append(meetingrequest)
                                self.month_year.append(monthyear!)
                            }
                        }
                    }) {
                        (error) -> Void in
                        print(error)
                    }
                }
                catch
                {
                    print("Unable to load data: \(error)")
                }
         }
    
    }
    
    /*BarChart View*/
    func setupView() {
        
        //legend
        let legend = barchart.legend
        legend.enabled = true
        legend.horizontalAlignment = .right
        legend.verticalAlignment = .top
        legend.orientation = .vertical
        legend.drawInside = true
        legend.yOffset = 10.0;
        legend.xOffset = 10.0;
        legend.yEntrySpace = 0.0;
        legend.textColor = UIColor.lightGray
        
        // Y - Axis Setup
        let yaxis = barchart.leftAxis
        yaxis.spaceTop = 0.35
        yaxis.axisMinimum = 0
        yaxis.drawGridLinesEnabled = false
        yaxis.labelTextColor = UIColor.lightGray
        yaxis.axisLineColor = UIColor.lightGray
        
        barchart.rightAxis.enabled = false
        
        // X - Axis Setup
        let xaxis = barchart.xAxis
        let formatter = CustomLabelsXAxisValueFormatter()//custom value formatter
        formatter.labels = self.dispMonth
        xaxis.valueFormatter = formatter
        xaxis.drawGridLinesEnabled = false
        xaxis.labelPosition = .bottom
        xaxis.labelTextColor = UIColor.lightGray
        xaxis.centerAxisLabelsEnabled = true
        xaxis.axisLineColor = UIColor.lightGray
        xaxis.granularityEnabled = true
        xaxis.enabled = true
        
        
        barchart.delegate = self
        //barchart.noDataText = "You need to provide data"
        barchart.noDataTextColor = UIColor.darkGray
        barchart.chartDescription?.textColor = UIColor.clear
        
        setChart(dispMonth: self.dispMonth, newgrev: self.new_grev, repetedgrev: self.repeeated_grev)
    }
    func setChart(dispMonth: [String], newgrev: [Double], repetedgrev: [Double]) {
        
        barchart.noDataText = "You need to provide data"
        var dataEntries: [BarChartDataEntry] = []
        var dataEntries1: [BarChartDataEntry] = []
        
        for i in 0..<self.dispMonth.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(self.repeeated_grev[i]))
            dataEntries.append(dataEntry)
            
            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: Double(self.new_grev[i]))
            dataEntries1.append(dataEntry1)
            
        }
        
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Greivances")
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "New Greivances")
        
        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1]
        chartDataSet.colors = [UIColor(red: 207/255, green: 255/255, blue: 216/255, alpha: 1.0)]
        chartDataSet1.colors = [UIColor(red: 219/255, green: 201/255, blue: 255/255, alpha: 1.0)]
        let chartData = BarChartData(dataSets: dataSets)
        
        let groupSpace = 0.4
        let barSpace = 0.03
        let barWidth = 0.2
        
        chartData.barWidth = barWidth
        barchart.xAxis.axisMinimum = 0.0
        barchart.xAxis.axisMaximum = 0.0 + chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(self.dispMonth.count)
        chartData.groupBars(fromX: 0.0, groupSpace: groupSpace, barSpace: barSpace)
        barchart.xAxis.granularity = barchart.xAxis.axisMaximum / Double(self.dispMonth.count)
        barchart.data = chartData
        barchart.notifyDataSetChanged()
        barchart.setVisibleXRangeMaximum(4)
        barchart.animate(yAxisDuration: 2.0, easingOption: .easeInBounce)
        barchart.backgroundColor = UIColor.white
        chartData.setValueTextColor(UIColor.lightGray)
    }
    
    //MARK:- ChartView Delegate -
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
//       print("\(entry.value) in \(xaxisValue[entry.x])")
    }
    
    @IBAction func graph(_ sender: Any) {
        self.performSegue(withIdentifier: "to_graph", sender: self)
    }
    
    @IBAction func CM(_ sender: Any)
    {
        self.to = "Cm"
        self.performSegue(withIdentifier: "to_cm", sender: self.to)

    }
    
    @IBAction func TM(_ sender: Any)
    {
        self.to = "Tm"
        self.performSegue(withIdentifier: "to_cm", sender: self.to)
    }
    
    @IBAction func GM(_ sender: Any)
    {
        self.to = "TG"
        self.performSegue(withIdentifier: "to_cm", sender: self.to)
    }
    
    @IBAction func CI(_ sender: Any)
    {
        self.performSegue(withIdentifier: "to_ci", sender: self.to)
    }
    
    /*
    func naigationWithAnimation ()
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "DashBoard", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "moreGraph") as! MoreGraph

        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        self.navigationController?.view.layer.add(transition, forKey: nil)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_graph")
        {
            let vc = segue.destination as! MoreGraph
            vc.grievance = self.grivenacegraph
            vc.month_year = self.month_year
            vc.meeting_request = self.meeting_request
        }
        else if (segue.identifier == "to_cm")
        {
            let vc = segue.destination as! Widgets
            vc.paguthi_Id = GlobalVariables.shared.selectedPaguthiId
            vc.From = self.to
        }
        else if (segue.identifier == "to_ci"){
            let vc = segue.destination as! WidgetInterAction
            vc.paguthi_Id = GlobalVariables.shared.selectedPaguthiId
        }
        else if (segue.identifier == "to_search"){
            let vc = segue.destination as! Search
            vc.keyWord = sender as! String
        }
    }
    

}

extension DashBoard : PaguthiView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == searchText
        {
            if searchText.text?.isEmpty == true{
               AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Empty", complition: {
               })
            }
            else{
                self.performSegue(withIdentifier: "to_search", sender: searchText.text)
                self.view.endEditing(true)
            }
        }
            return true
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == area{
            self.callAPIPaguthi ()
        }
        return true
    }
    
    /*Presenter Delegate*/
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
            self.paguthiName.append(paguthi)
            self.paguthiId.append(id)
         }
         self.paguthiName.insert("ALL", at: 0)
         self.paguthiId.insert("ALL", at: 0)
         pickerView.reloadAllComponents()
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            self.dismiss(animated: false, completion: nil)
         })
    }
    /*Picker View*/
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return self.paguthiName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return self.paguthiName[row] // dropdown item
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         area.text = self.paguthiName[row] // selected item
         GlobalVariables.shared.selectedPaguthiId = self.paguthiId[row]
    }
        
}




