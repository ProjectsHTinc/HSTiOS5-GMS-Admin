//
//  GarphFootFallVC.swift
//  GMS Admin
//
//  Created by HappysanziMac on 27/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit
import Charts
import Alamofire
import SwiftyJSON

class GarphFootFallVC: UIViewController, ChartViewDelegate {

    @IBOutlet var barchart:BarChartView!
    
    var dispMonth = [String]()
    var new_grev = [Double]()
    var repeeated_grev = [Double]()
    var total = [Double]()
    var grivenacegraph = [Double]()
    var meeting_request = [Double]()
    var month_year = [String]()
    var paguthiData = [PaguthiData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        callAPI (paguthi:GlobalVariables.shared.selectedPaguthiId,FromDate:GlobalVariables.shared.widgetFromDate,ToDate:GlobalVariables.shared.widgetToDate,dynamic_db:GlobalVariables.shared.dynamic_db)
    }
    
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
    
            setChart(dispMonth: self.dispMonth, newgrev: self.new_grev, repetedgrev: self.repeeated_grev, totalgrev: self.total)
        }
    
        func setChart(dispMonth: [String], newgrev: [Double], repetedgrev: [Double], totalgrev: [Double]) {
    
            barchart.noDataText = "You need to provide data"
            var dataEntries: [BarChartDataEntry] = []
            var dataEntries1: [BarChartDataEntry] = []
            var dataEntries2: [BarChartDataEntry] = []
    
            for i in 0..<self.dispMonth.count {
    
                let dataEntry = BarChartDataEntry(x: Double(i) , y: Double(self.repeeated_grev[i]))
                dataEntries.append(dataEntry)
    
                let dataEntry1 = BarChartDataEntry(x: Double(i) , y: Double(self.new_grev[i]))
                dataEntries1.append(dataEntry1)
    
                let dataEntry2 = BarChartDataEntry(x: Double(i) , y: Double(self.total[i]))
                dataEntries2.append(dataEntry2)
            }
    
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Repeated Greivances")
            let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "New Greivances")
            let chartDataSet2 = BarChartDataSet(entries: dataEntries2, label: "Total Greivances")
            let dataSets: [BarChartDataSet] = [chartDataSet,chartDataSet1,chartDataSet2]
            chartDataSet.colors = [UIColor(red: 219/255, green: 201/255, blue: 255/255, alpha: 1.0)]
            chartDataSet1.colors = [UIColor(red: 207/255, green: 255/255, blue: 216/255, alpha: 1.0)]
            chartDataSet2.colors = [UIColor(red: (33/255), green: (132/255), blue: (217/255), alpha: 1.0)]
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
}
