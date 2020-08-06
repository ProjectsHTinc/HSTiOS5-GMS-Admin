//
//  Graph.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 09/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import Charts

class MoreGraph: UIViewController, ChartViewDelegate {

    var grievance = [Double]()
    var grievanceName = [String]()
    var meeting_request = [Double]()
    var month_year = [String]()

    @IBOutlet var pirechartView: PieChartView!
    @IBOutlet var linechartView: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Set Values for PieChart*/
        self.grievanceName = ["Completed","Processing","Enquiry"]
        /*Pie Chart*/
        self.SetPieChart()
        /*Line Chart*/
        self.setLineChart()
        self.addCustomizedBackBtn(title:"  Graph")
    }
    
    func SetPieChart(){
         // This will align label text to top right corner
         self.customizeChart(dataPoints: self.grievanceName, values: self.grievance)
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
          // 1. Set ChartDataEntry
          var dataEntries: [ChartDataEntry] = []
          for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
          }
          // 2. Set ChartDataSet
          let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
          var colors: [UIColor] = []
          let redcolor = UIColor(red:(219/255), green: (201/255), blue: (255/255),alpha: 1.0)
          let greencolor = UIColor(red: (33/255), green: (132/255), blue: (217/255), alpha: 1.0)
          let orangecolor = UIColor(red: (207/255), green: (255/255), blue: (216/255), alpha: 1.0)
          colors.append(redcolor)
          colors.append(orangecolor)
          colors.append(greencolor)
          pieChartDataSet.colors = colors
        
          // 3. Set ChartData
          let pieChartData = PieChartData(dataSet: pieChartDataSet)
          let format = NumberFormatter()
          format.numberStyle = .none
          let formatter = DefaultValueFormatter(formatter: format)
          pieChartData.setValueFormatter(formatter)
          // 4. Assign it to the chart’s data
          pirechartView.data = pieChartData
          pirechartView.holeRadiusPercent = 0
          pirechartView.transparentCircleColor = UIColor.clear
          pirechartView.backgroundColor = UIColor.white
          pirechartView.drawEntryLabelsEnabled = false
          pirechartView.legend.textColor = UIColor.black
          pirechartView.noDataText = "You need to provide data"
          pirechartView.noDataTextColor = UIColor.black

    }
    
    func setLineChart(){
        self.setChartData(months: self.month_year, dollar: self.meeting_request)
    }
    
    func setChartData(months : [String],dollar : [Double]) {

        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0 ..< months.count {
            yVals1.append(ChartDataEntry(x:Double(i) , y:dollar[i]))
        }
        let set1: LineChartDataSet = LineChartDataSet(entries: yVals1, label: "")
        set1.axisDependency = .left // Line will correlate with left axis values
        set1.setColor(UIColor(red: (219/255), green: (201/255), blue: (255/255),alpha: 1.0))
        set1.setCircleColor(UIColor(red: (45/255), green: (148/255), blue: (235/255),alpha: 1.0))
        set1.circleRadius = 3.0
        // set1.fillAlpha = 65 / 255.0
        // set1.fillColor = UIColor.blue
        // set1.highlightColor = UIColor.black
        set1.drawCircleHoleEnabled = false
        //3 - create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        //4 - pass our months in for our x-axis label value along with our dataSets
        let data : LineChartData = LineChartData(dataSets: dataSets)
        linechartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        // data.setValueTextColor(UIColor.white)
        //5 - finally set our data
        self.linechartView.data = data
        linechartView.xAxis.granularity = 1 //  to show intervals
        linechartView.xAxis.wordWrapEnabled = true
        linechartView.xAxis.labelFont = UIFont.boldSystemFont(ofSize: 8.0)
        linechartView.xAxis.labelPosition = .bottom // lebel position on graph
        linechartView.legend.form = .line // indexing shape
        linechartView.xAxis.drawGridLinesEnabled = false // show gird on graph
        linechartView.xAxis.labelTextColor = UIColor.darkGray
        linechartView.leftAxis.labelTextColor = UIColor.darkGray
        linechartView.rightAxis.drawLabelsEnabled = false// to show right side value on graph
        linechartView.data?.setDrawValues(false) //
        linechartView.chartDescription?.text = ""
        linechartView.doubleTapToZoomEnabled = false
        linechartView.pinchZoomEnabled = false
        linechartView.scaleXEnabled = false
        linechartView.scaleYEnabled = false
        linechartView.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
        linechartView.backgroundColor = UIColor.white
        linechartView.noDataText = "You need to provide data"
        linechartView.noDataTextColor = UIColor.black
    }
    
//    func setChart(dataPoints: [String], values: [Double]) {
//
//
//
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
