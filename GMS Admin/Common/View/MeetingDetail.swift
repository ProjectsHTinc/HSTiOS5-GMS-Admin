//
//  MeetingDetail.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingDetail: UIViewController {

    var meeting_Title = String()
    var meeting_Discrption = String()
    var meeting_Date = String()
    var meeting_Status = String()

    @IBOutlet var meetingTitle: UILabel!
    @IBOutlet var meetingDiscrption: UILabel!
    @IBOutlet var meetingDate: UILabel!
    @IBOutlet var meetingStatus: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Set Values*/
        self.addCustomizedBackBtn(title:"  Details of Meeting")
        self.meetingTitle.text = meeting_Title
        self.meetingDiscrption.text = meeting_Discrption.capitalized
        let formatted = self.formattedDateFromString(dateString: meeting_Date, withFormat: "dd-MM-YYYY")
        self.meetingDate.text =  String(format: "%@ %@", "Date :",formatted!)
        self.meetingStatus.text = meeting_Status
        
        if self.meetingStatus.text == "Requested" || self.meetingStatus.text == "Processing"
        {
            self.meetingStatus.textColor =  UIColor(red: 253.0/255, green: 166.0/255, blue: 68.0/255, alpha: 1.0)

        }
        else{
            self.meetingStatus.textColor =  UIColor(red: 112.0/255, green: 173.0/255, blue: 71.0/255, alpha: 0.6)
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
