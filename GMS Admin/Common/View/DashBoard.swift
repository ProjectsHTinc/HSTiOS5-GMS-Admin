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
import SideMenu

class DashBoard: UIViewController, ChartViewDelegate,OfficeView,SideMenuNavigationControllerDelegate {
       
//    @IBOutlet var searchText: TextFieldWithImage!
    @IBOutlet var fromDate: TextFieldWithImage!
    @IBOutlet var toDate: TextFieldWithImage!
    @IBOutlet var area: UITextField!
    @IBOutlet var office: UITextField!
    @IBOutlet weak var meetingLabel: UILabel!
//    @IBOutlet var barchart: BarChartView!
    @IBOutlet weak var volounterLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var vedioLabel: UILabel!
    @IBOutlet weak var grievanceLabel: UILabel!
    @IBOutlet weak var footfallLabel: UILabel!
    @IBOutlet weak var constituentLabel: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var containerView1: UIView!
    @IBOutlet weak var containerView2: UIView!
    @IBOutlet weak var dashboardView: UIView!
    
//    paguthi_id
    /*Get Paguthi List*/
    let presenter = PaguthiPresenter(areaService: AreaService())
    var paguthiData = [PaguthiData]()
    var paguthiName = [String]()
    var paguthiId = [String]()
    let pickerView = UIPickerView()
    let datePicker = UIDatePicker()
//    var selctedPaguthiId = String ()
    var dispMonth = [String]()
    var new_grev = [Double]()
    var repeeated_grev = [Double]()
    var total = [Double]()
    var grivenacegraph = [Double]()
    var meeting_request = [Double]()
    var month_year = [String]()
    var selectedFromDate = Date()
    var selectedToDate = Date()
    var textfieldName = String()
    var fromDateFormatted = String()
    var toDateFormatted = String()
    var to = String()
    var segmentTitle = [String]()
    var segmentedControl = HMSegmentedControl()
    let presenterOffice = OfficePresenter(officeService: OfficeService())
    var officeData = [OfficeData]()
    var officeName = [String]()
    var officeId = [String]()
    var selectedofficeID  = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentTitle = ["DashBoard","Footfall Graph"]
        containerView1.alpha = 0
        containerView2.alpha = 0
        dashboardView.alpha = 0
    
        self.setViewShadow()
        let dynamic_db = UserDefaults.standard.object(forKey:"dynamicDBKey") ?? ""
        
        if dynamic_db as! String == ""
        {

        }
        else {
            GlobalVariables.shared.dynamic_db = UserDefaults.standard.object(forKey: "dynamicDBKey") as! String
            print(GlobalVariables.shared.dynamic_db)
        }

        // Do any additional setup after loading the view.
        /*Removeing NavigationBar Bottom Line*/
        self.showDatePicker()
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.layoutIfNeeded()
        //setupSideMenu()
        /*Set delegate*/
//        self.searchText.delegate = self
        self.area.delegate = self
        /*Set PlaceHolder textColor*/
        area.attributedPlaceholder =
        NSAttributedString(string: "Select Paguthi", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 188 / 255, green: 188 / 255, blue: 188 / 255, alpha: 1.0)])
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
        
        GlobalVariables.shared.widgetFromDate = fromDateFormatted
        GlobalVariables.shared.widgetToDate = toDateFormatted
        
        segmentView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.darkGray, radius: 2.0, opacity: 0.35)
        
        self.callAPI(paguthi:GlobalVariables.shared.selectedPaguthiId,FromDate:"",ToDate:"",dynamic_db:GlobalVariables.shared.dynamic_db)
        callAPIOffice ()
//        setupView()
        /*Tap anywhere to hide keypad*/
        self.hideKeyboardWhenTappedAround()
        setUpSegementControl ()
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        self.view.isHidden = false
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    @IBAction func clear_Action(_ sender: Any) {
        
        self.fromDate.text = ""
        self.toDate.text = ""
        self.area.text = ""
        self.office.text = ""
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
    
    func setUpSegementControl ()
    {
        segmentedControl = HMSegmentedControl(sectionTitles: self.segmentTitle)
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl.frame = CGRect(x: 0, y: 0, width: self.segmentView.frame.width, height: 50)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        segmentView.addSubview(segmentedControl)
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentedControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.bottom
        segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyle.fixed
        segmentedControl.selectionIndicatorHeight = 4.0
        segmentedControl.selectionIndicatorColor = UIColor.black
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Medium", size: 15.0)!]
    }
    
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
    
        if segmentedControl.selectedSegmentIndex == 0 {
            containerView1.alpha = 0
            containerView2.alpha = 0
            dashboardView.alpha = 0
        }
        else if segmentedControl.selectedSegmentIndex == 1 {
            dashboardView.alpha = 0
            containerView1.alpha = 1
            containerView2.alpha = 0
        }
//        else {
//            dashboardView.alpha = 0
//            containerView1.alpha = 0
//            containerView2.alpha = 1
//        }
    }
    
    func callAPIPaguthi ()
    {
        presenter.attachView(view: self)
        presenter.getPaguthi(constituency_id: GlobalVariables.shared.constituent_Id,dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
    func callAPIOffice ()
    {
        presenterOffice.attachView(view: self)
        presenterOffice.getOffice(constituency_id: GlobalVariables.shared.constituent_Id, dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        //SideMenuPresentationStyle.menuSlideIn
        SideMenuManager.default.leftMenuNavigationController?.settings = makeSettings()
//        SideMenuManager.default.menuAnimationFadeStrength = 0.5
//        SideMenuManager.menuWidth = 240
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
//        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
//        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func makeSettings() -> SideMenuSettings{
        
        var settings = SideMenuSettings()
        settings.allowPushOfSameClassTwice = false
        settings.presentationStyle = .menuDissolveIn
        settings.presentationStyle.backgroundColor = .black
        settings.presentationStyle.presentingEndAlpha = 0
        settings.dismissOnPresent = true
        settings.menuWidth = 400
        settings.presentationStyle.onTopShadowOpacity = 0.5
        settings.statusBarEndAlpha = 1
        settings.presentationStyle.menuStartAlpha = 0.5
        
        return settings
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
//       toolBar.barTintColor = UIColor(red: 250/255.0, green: 250/255.0, blue: 248/255.0, alpha: 1.0)
         toolBar.tintColor = UIColor(red: 45/255.0, green: 148/255.0, blue: 235/255.0, alpha: 1.0)
         toolBar.isUserInteractionEnabled = true
         toolBar.isTranslucent = false
         area.inputView = pickerView
         area.inputAccessoryView = toolBar
         office.inputView = pickerView
         office.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        
          let row = self.pickerView.selectedRow(inComponent: 0)
          self.pickerView.selectRow(row, inComponent: 0, animated: false)
        
          if self.area.isFirstResponder{
             area.text = self.paguthiName[row]// selected item
             GlobalVariables.shared.selectedPaguthiId = self.paguthiId[row]
          }
          else if self.office.isFirstResponder{
            self.office.text = self.officeName[row]
            self.selectedofficeID = self.officeId[row]
          }
          self.CheckValuesAreEmpty()
//          self.callAPI(paguthi:GlobalVariables.shared.selectedPaguthiId)
          self.area.resignFirstResponder()
          self.office.resignFirstResponder()
          view.endEditing(true)
    }
    
    @objc func cancel() {
          view.endEditing(true)
    }
    
    func callAPI (paguthi:String,FromDate:String,ToDate:String,dynamic_db:String)
    {
        let url = GlobalVariables.shared.CLIENTURL + "apiandroid/dashBoard/"
        let parameters = ["paguthi": paguthi,"from_date":FromDate,"to_date":ToDate,"dynamic_db":dynamic_db]
//        self.view.activityStartAnimating()
        DispatchQueue.global().async
            {
            do
                {
                    try AFWrapper.requestPOSTURL(url, params: (parameters), headers: nil, success: {
                        (JSONResponse) -> Void in
                        self.view.activityStopAnimating()
                        let json = JSON(JSONResponse)
                        print(json)
                        let msg = json["msg"].stringValue
                        let status = json["status"].stringValue
                        if msg == "Dashboard Details" && status == "Success"
                        {
                            self.constituentLabel.text = json["widgets_count"]["constituent_count"].stringValue
                            self.meetingLabel.text = json["widgets_count"]["meeting_count"].stringValue
                            self.grievanceLabel.text = json["widgets_count"]["grievance_count"].stringValue
                            self.vedioLabel.text = json["widgets_count"]["video_count"].stringValue
                            self.volounterLabel.text = json["widgets_count"]["volunter_count"].stringValue
                            self.greetingLabel.text = json["widgets_count"]["geeting_count"].stringValue
                            self.footfallLabel.text = json["widgets_count"]["footfall_count"].stringValue
                            
//                            GlobalVariables.shared.constituent_MemberCount = self.constituentlabel.text!
                            GlobalVariables.shared.totalMeetingsCount = self.meetingLabel.text!
                            GlobalVariables.shared.totalGrievancesCount = self.grievanceLabel.text!
                            //GlobalVariables.shared.interActionCount = self.interactionLabel.text!
//                            GlobalVariables.shared.constituentInteractionCount = self.interactionLabel.text!

                            self.dispMonth.removeAll()
                            self.new_grev.removeAll()
                            self.repeeated_grev.removeAll()
                            self.total.removeAll()
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
                                let _total = dict["total"].double
                                
                                self.dispMonth.append(dispMonth!)
                                self.new_grev.append(newGrev!)
                                self.repeeated_grev.append(repeatedGrev!)
                                self.total.append(_total!)

                            }
//                            self.setupView()
                            /*Pie Chart*/
                            //let gerv_count = json["grievance_graph"]["gerv_count"].doubleValue
                            let gerv_enquiry = json["grievance_graph"]["gerv_ecount"].doubleValue
                            let gerv_processing = json["grievance_graph"]["gerv_ppcount"].doubleValue
                            let gerv_completed = json["grievance_graph"]["gerv_pccount"].doubleValue

                            //self.grivenacegraph.insert(gerv_count, at: 0)
                            self.grivenacegraph.insert(gerv_enquiry, at: 0)
                            self.grivenacegraph.insert(gerv_processing, at: 1)
                            self.grivenacegraph.insert(gerv_completed, at: 2)

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
//    func setupView() {
//
//        //legend
//        let legend = barchart.legend
//        legend.enabled = true
//        legend.horizontalAlignment = .right
//        legend.verticalAlignment = .top
//        legend.orientation = .vertical
//        legend.drawInside = true
//        legend.yOffset = 10.0;
//        legend.xOffset = 10.0;
//        legend.yEntrySpace = 0.0;
//        legend.textColor = UIColor.lightGray
//
//        // Y - Axis Setup
//        let yaxis = barchart.leftAxis
//        yaxis.spaceTop = 0.35
//        yaxis.axisMinimum = 0
//        yaxis.drawGridLinesEnabled = false
//        yaxis.labelTextColor = UIColor.lightGray
//        yaxis.axisLineColor = UIColor.lightGray
//        barchart.rightAxis.enabled = false
//
//        // X - Axis Setup
//        let xaxis = barchart.xAxis
//        let formatter = CustomLabelsXAxisValueFormatter()//custom value formatter
//        formatter.labels = self.dispMonth
//        xaxis.valueFormatter = formatter
//        xaxis.drawGridLinesEnabled = false
//        xaxis.labelPosition = .bottom
//        xaxis.labelTextColor = UIColor.lightGray
//        xaxis.centerAxisLabelsEnabled = true
//        xaxis.axisLineColor = UIColor.lightGray
//        xaxis.granularityEnabled = true
//        xaxis.enabled = true
//        barchart.delegate = self
//
//        //barchart.noDataText = "You need to provide data"
//        barchart.noDataTextColor = UIColor.darkGray
//        barchart.chartDescription?.textColor = UIColor.clear
//
//        setChart(dispMonth: self.dispMonth, newgrev: self.new_grev, repetedgrev: self.repeeated_grev, totalgrev: self.total)
//    }
//    func setChart(dispMonth: [String], newgrev: [Double], repetedgrev: [Double], totalgrev: [Double]) {
//
//        barchart.noDataText = "You need to provide data"
//        var dataEntries: [BarChartDataEntry] = []
//        var dataEntries1: [BarChartDataEntry] = []
//        var dataEntries2: [BarChartDataEntry] = []
//
//        for i in 0..<self.dispMonth.count {
//
//            let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(self.repeeated_grev[i]))
//            dataEntries.append(dataEntry)
//
//            let dataEntry1 = BarChartDataEntry(x: Double(i) , y: Double(self.new_grev[i]))
//            dataEntries1.append(dataEntry1)
//
//            let dataEntry2 = BarChartDataEntry(x: Double(i) , y: Double(self.total[i]))
//            dataEntries2.append(dataEntry2)
//
//        }
//
//        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Repeated Greivances")
//        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "New Greivances")
//        let chartDataSet2 = BarChartDataSet(entries: dataEntries2, label: "Total Greivances")
//        let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1,chartDataSet2]
//        chartDataSet.colors = [UIColor(red: 219/255, green: 201/255, blue: 255/255, alpha: 1.0)]
//        chartDataSet1.colors = [UIColor(red: 207/255, green: 255/255, blue: 216/255, alpha: 1.0)]
//        chartDataSet2.colors = [UIColor(red: (33/255), green: (132/255), blue: (217/255), alpha: 1.0)]
//        let chartData = BarChartData(dataSets: dataSets)
//
//        let groupSpace = 0.4
//        let barSpace = 0.03
//        let barWidth = 0.2
//
//        chartData.barWidth = barWidth
//        barchart.xAxis.axisMinimum = 0.0
//        barchart.xAxis.axisMaximum = 0.0 + chartData.groupWidth(groupSpace: groupSpace, barSpace: barSpace) * Double(self.dispMonth.count)
//        chartData.groupBars(fromX: 0.0, groupSpace: groupSpace, barSpace: barSpace)
//        barchart.xAxis.granularity = barchart.xAxis.axisMaximum / Double(self.dispMonth.count)
//        barchart.data = chartData
//        barchart.notifyDataSetChanged()
//        barchart.setVisibleXRangeMaximum(4)
//        barchart.animate(yAxisDuration: 2.0, easingOption: .easeInBounce)
//        barchart.backgroundColor = UIColor.white
//        chartData.setValueTextColor(UIColor.lightGray)
//    }
    
    //MARK:- ChartView Delegate -
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: Highlight) {
//       print("\(entry.value) in \(xaxisValue[entry.x])")
    }
    
    @IBAction func graph(_ sender: Any) {
        self.performSegue(withIdentifier: "to_graph", sender: self)
    }
    
    @IBAction func volounteerCount(_ sender: Any) {
        self.performSegue(withIdentifier: "to_volunteer", sender: self)
    }
  
    @IBAction func MeetingCount(_ sender: Any) {
      
        self.performSegue(withIdentifier: "to_meeting", sender: self)
    }
    
    @IBAction func vedioCount(_ sender: Any) {
        
        self.performSegue(withIdentifier: "to_vedio", sender: self)
    }
    
    @IBAction func GC(_ sender: Any) {
       
        self.performSegue(withIdentifier: "to_GC", sender: self.to)
    }
    
    @IBAction func FF(_ sender: Any) {
        
        self.performSegue(withIdentifier: "to_FF", sender: self.to)
    }
    @IBAction func greetingCount(_ sender: Any) {
        
        self.performSegue(withIdentifier: "greetingCount", sender: self.to)
    }
    
    @IBAction func constituentCount(_ sender: Any) {
        self.performSegue(withIdentifier: "const_member", sender: self.to)
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
        else if (segue.identifier == "const_member")
        {
            let vc = segue.destination as! Widgets
            vc.paguthi_Id = GlobalVariables.shared.selectedPaguthiId
        }
        else if (segue.identifier == "to_ci"){
            let vc = segue.destination as! WidgetInterAction
            vc.paguthi_Id = GlobalVariables.shared.selectedPaguthiId
        }
        else if (segue.identifier == "to_search"){
            let vc = segue.destination as! Search
            vc.keyWord = sender as! String
            vc.from = "dh"
        }
        else if (segue.identifier == "to_GC"){
            let vc = segue.destination as! WidgetGrievance
            vc.paguthi_Id = sender as! String
        }
        else if (segue.identifier == "to_FF"){
            let vc = segue.destination as! WidgetFootFall
            vc.paguthi_Id = sender as! String
        }
        else if (segue.identifier == "to_meeting"){
            let vc = segue.destination as! WidgetsMeeting
            vc.paguthi_Id = GlobalVariables.shared.selectedPaguthiId
        }
        else if (segue.identifier == "to_vedio"){
            let vc = segue.destination as! WidgetVedio
            vc.paguthi_Id = GlobalVariables.shared.selectedPaguthiId
        }
        else if (segue.identifier == "greetingCount"){
            let vc = segue.destination as! GreetingCount
            vc.paguthi_Id = GlobalVariables.shared.selectedPaguthiId
        }
        else if (segue.identifier == "to_volunteer"){
            let vc = segue.destination as! WidgetVolounteer
            vc.paguthi_Id = GlobalVariables.shared.selectedPaguthiId
        }
//        else
//        {
//            guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
//            sideMenuNavigationController.settings = makeSettings()
//        }
    }
}

extension DashBoard : PaguthiView, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

//    func textFieldShouldReturn(_ textField: UITextField) -> Bool
//    {
//        if textField == searchText
//        {
//            if searchText.text?.isEmpty == true{
//               AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "Empty", complition: {
//               })
//            }
//            else{
//                self.performSegue(withIdentifier: "to_search", sender: searchText.text)
//                self.view.endEditing(true)
//            }
//        }
//            return true
//    }
//    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == area{
            self.callAPIPaguthi ()
        }
        else if textField == office {
            self.callAPIOffice ()
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
            self.paguthiName.append(paguthi.capitalized)
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
        
        if self.area.isFirstResponder{
         return self.paguthiName.count
        }
        else
        {
            return self.officeName.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.area.isFirstResponder{
         return self.paguthiName[row]
        }
        else
        {
            return self.officeName[row]
        }
    }
    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//         area.text = self.paguthiName[row] // selected item
//         GlobalVariables.shared.selectedPaguthiId = self.paguthiId[row]
//    }
    func showDatePicker() {
        
       //Formate Date
       datePicker.datePickerMode = .date
       datePicker.backgroundColor = UIColor.white
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
//        datePicker.datePickerStyle = .
       datePicker.setValue(UIColor.black, forKeyPath: "textColor")

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
//
        }
        self.officeName.insert("ALL", at: 0)
        self.officeId.insert("ALL", at: 0)
        pickerView.reloadAllComponents()
    }
    
    func CheckValuesAreEmpty () {
        
        _ = selectedFromDate.timeIntervalSince1970 < selectedToDate.timeIntervalSince1970
        
          if self.fromDate.text?.count == 0   {
                AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "From Date is Empty", complition: {
                    
                })
        }
            
           else if self.toDate.text?.count == 0 {
                  AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "To Date is Empty", complition: {
                      
                })
        }
           
            else  {
                 self.callAPI(paguthi:GlobalVariables.shared.selectedPaguthiId,FromDate:fromDateFormatted,ToDate:toDateFormatted,dynamic_db:GlobalVariables.shared.dynamic_db)
        }
    }
    
    func setViewShadow() {
        
                view1.layer.masksToBounds = false
                view1?.layer.shadowColor = UIColor.darkGray.cgColor
                view1?.layer.shadowOffset =  CGSize.zero
                view1?.layer.shadowOpacity = 0.4
                view1?.layer.shadowRadius = 2
                
                view2.layer.masksToBounds = false
                view2?.layer.shadowColor = UIColor.darkGray.cgColor
                view2?.layer.shadowOffset =  CGSize.zero
                view2?.layer.shadowOpacity = 0.4
                view2?.layer.shadowRadius = 2
                
                view3.layer.masksToBounds = false
                view3?.layer.shadowColor = UIColor.darkGray.cgColor
                view3?.layer.shadowOffset =  CGSize.zero
                view3?.layer.shadowOpacity = 0.4
                view3?.layer.shadowRadius = 2
                
                view4.layer.masksToBounds = false
                view4?.layer.shadowColor = UIColor.darkGray.cgColor
                view4?.layer.shadowOffset =  CGSize.zero
                view4?.layer.shadowOpacity = 0.4
                view4?.layer.shadowRadius = 2
                
                view5.layer.masksToBounds = false
                view5?.layer.shadowColor = UIColor.darkGray.cgColor
                view5?.layer.shadowOffset =  CGSize.zero
                view5?.layer.shadowOpacity = 0.4
                view5?.layer.shadowRadius = 2
                
                view6.layer.masksToBounds = false
                view6?.layer.shadowColor = UIColor.darkGray.cgColor
                view6?.layer.shadowOffset =  CGSize.zero
                view6?.layer.shadowOpacity = 0.4
                view6?.layer.shadowRadius = 2
                
                view7.layer.masksToBounds = false
                view7?.layer.shadowColor = UIColor.darkGray.cgColor
                view7?.layer.shadowOffset =  CGSize.zero
                view7?.layer.shadowOpacity = 0.4
                view7?.layer.shadowRadius = 2
    }
}
