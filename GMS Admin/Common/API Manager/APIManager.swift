//
//  APIManager.swift
//  GMS Admin
//
//  Created by Happy Sanz Tech on 06/07/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

let MAIN_URL = "https://happysanz.in/superadmingms/api"

class APIManager: NSObject {
    
      static let instance = APIManager()
      var manager: SessionManager {
          let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 3.0
          return manager
      }
      
      enum RequestMethod {
          case get
          case post
      }
    
      enum Endpoint: String {
          case constituencyList = "/list"
          case clientUrl = "/details"
          case versionUrl = "apiios/version_check/"
          case loginUrl = "apiios/login/"
          case forgotPasswordUrl = "apiios/forgotPassword"
          case searchUrl = "apiios/dashBoard_searchnew"
          case dashUrl = "apiios/dashBoard"
          case paguthiUrl = "apiios/listPaguthi"
          case constituentMembers = "apiios/widgets_members"
          case totalMeetingsUrl = "apiios/widgets_meetings"
          case totalGreivancesUrl = "apiios/widgets_grievances"
          case constituentInteractionUrl = "apiios/widgets_interactions"
          case listConstituentUrl = "apiios/listConstituentnew"
          case constituentDetailUrl = "apiios/constituentDetails"
          case constituentmeetingUrl = "apiios/constituentMeetings"
          case plantDonationUrl = "apiios/constituentPlant"
          case interactionUrl = "apiios/constituentInteraction"
          case constituentDocUrl = "apiios/constituentDocuments"
          case grievanceDocUrl = "apiios/constituentgrvDocuments"
          case constituentgrievanceUrl = "apiios/constituentGrievances"
          case grievancesmeetingUrl = "apiios/grievanceMessage"
          case meetingAllUrl = "apiios/meetingRequestnew"
          case meetingAllDetailUrl = "apiios/meetingDetails"
          case meetingAllDetailsUpdateUrl = "apiios/meetingUpdate"
          case staffUrl = "apiios/listStaff"
          case staffDetailUrl = "apiios/staffDetails"
          case categoeryUrl = "apiios/activeCategory"
          case SubcategoeryUrl = "apiios/activeSubcategory"
//        case otpUrl = "apiconstituentios/mobile_verify"
//        case bannerImageUrl = "apiconstituentios/view_banners"
//        case newsFeedUrl = "apiconstituentios/newsfeed_list"
//        case grivencesUrl = "apiconstituentios/greivance_list"
//        case meetingUrl = "apiconstituentios/meeting_list"
//        case plantDonationUrl = "apiconstituentios/get_plant_donation"
//        case notificationUrl = "apiconstituentios/notification_list"
//        case profilrUrl = "apiconstituentios/user_details"
      }
      
      // MARK: GET CONSTITUENCY LIST RESPONSE
    func callAPIGetConstituencyList(partyID:String, onSuccess successCallback: ((_ constituencyName: [ConstituencyModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          // Build URL
          let url = MAIN_URL + Endpoint.constituencyList.rawValue
          // Set Parameters
          let parameters: Parameters =  ["party_id": partyID]
          // call API
          self.createRequestForConstituencyList(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
          // Create dictionary
          print(responseObject)
            
            guard let msg = responseObject["msg"].string, msg == "constituency found" else{
                failureCallback?(responseObject["msg"].string!)
                return
          }

          if let responseDict = responseObject["data"].arrayObject
            {
                  let constituencyList = responseDict as! [[String:AnyObject]]
                  // Create object
                  var data = [ConstituencyModel]()
                  for item in constituencyList {
                      let single = ConstituencyModel.build(item)
                      data.append(single)
                  }
                  // Fire callback
                  successCallback?(data)
             } else {
                  failureCallback?("An error has occured.")
              }
          },
          onFailure: {(errorMessage: String) -> Void in
              failureCallback?(errorMessage)
          }
       )
      }
      
      // MARK: MAKE CONSTITUENCY LIST REQUEST
      func createRequestForConstituencyList(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
      {
          manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
              print(responseObject)
              
              if responseObject.result.isSuccess
              {
                  let resJson = JSON(responseObject.result.value!)
                  successCallback?(resJson)
              }
              
              if responseObject.result.isFailure
              {
                 let error : Error = responseObject.result.error!
                  failureCallback!(error.localizedDescription)
              }
          }
      }
    
    //MARK: GET CLIENT URL RESPONSE
    func callAPIGetClientUrl(select_ID:String,onSuccess successCallback: ((_ client_url: [ClientUrlModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.clientUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["id": select_ID]
        // call API
        self.createRequestGetClientUrl(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "constituency found" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        if let responseDict = responseObject["data"].arrayObject
          {
                let clientUrlModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [ClientUrlModel]()
                for item in clientUrlModel {
                    let single = ClientUrlModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE CLIENT URL REQUEST
    func createRequestGetClientUrl(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET APPVERSION RESPONSE
    func callAPIAppversion(version_code:String, onSuccess successCallback: ((_ appversion: AppVersionModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.versionUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["version_code": version_code]
        // call API
        self.createRequestForAppversion(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "error" else{
              failureCallback?(responseObject["status"].string!)
              return
        }
            
            let status =  responseObject["status"].string
            let sendToModel = AppVersionModel()
            sendToModel.status = status
            successCallback?(sendToModel)
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    
    // MARK: MAKE APPVERSION REQUEST
    func createRequestForAppversion(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET LOGIN RESPONSE
    func callAPILogin(user_name:String, password:String, onSuccess successCallback: ((_ login: LoginModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.loginUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_name": user_name,"password": password,"device_id":GlobalVariables.shared.Devicetoken ,"mobile_type":Globals.mobileType]
        // call API
        self.createRequestForLogin(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Login Successfully" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
          
            let user_id = responseObject["userData"]["user_id"].string
            let picture_url = responseObject["userData"]["picture_url"].string
            let full_name = responseObject["userData"]["full_name"].string
            let address = responseObject["userData"]["address"].string

            let sendToModel = LoginModel()
            sendToModel.user_id = user_id
            sendToModel.picture_url = picture_url
            sendToModel.full_name = full_name
            sendToModel.address = address
            successCallback?(sendToModel)
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    
    // MARK: MAKE LOGIN REQUEST
    func createRequestForLogin(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET FORGOT PASSWORD RESPONSE
    func callAPIFp(user_name:String, onSuccess successCallback: ((_ fp: ForgotPasswordModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.forgotPasswordUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_name": user_name]
        // call API
        self.createRequestForLogin(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "success" else{
              failureCallback?(responseObject["status"].string!)
              return
        }
          
            let status = responseObject["success"].string
            let sendToModel = ForgotPasswordModel()
            sendToModel.status = status
            successCallback?(sendToModel)
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    
    // MARK: MAKE FORGOT PASSWORD REQUEST
    func createRequestForFp(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET SEARCH RESPONSE
    func callAPISearch(keyword:String, offset:String, rowcount:String, onSuccess successCallback: ((_ client_url: [SearchModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.searchUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["keyword": keyword, "offset": offset, "rowcount": rowcount]
        // call API
        self.createRequestSearch(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Search Result" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        if let responseDict = responseObject["search_result"].arrayObject
          {
                let searchModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [SearchModel]()
                for item in searchModel {
                    let single = SearchModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE SEARCH URL REQUEST
    func createRequestSearch(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET PAGUTHI URL RESPONSE
    func callAPIPaguthi(constituency_id:String,onSuccess successCallback: ((_ paguthi: [AreaModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.paguthiUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["constituency_id": constituency_id]
        // call API
        self.createRequestPaguthi(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "List Paguthi" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        if let responseDict = responseObject["paguthi_details"].arrayObject
          {
                let areaModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [AreaModel]()
                for item in areaModel {
                    let single = AreaModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE PAGUTHI URL REQUEST
    func createRequestPaguthi(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET Constituency Members RESPONSE
    func callAPIConstituentMembers(paguthi:String,onSuccess successCallback: ((_ constituentMember: ConstituentMemberModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.constituentMembers.rawValue
        // Set Parameters
        let parameters: Parameters =  ["paguthi": paguthi]
        // call API
        self.createRequestConstituentMembers(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Constituent Details" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

              let member_count = responseObject["constituent_details"]["member_count"].int
              let male_count = responseObject["constituent_details"]["male_count"].int
              let female_count = responseObject["constituent_details"]["female_count"].int
              let voterid_count = responseObject["constituent_details"]["voterid_count"].int
              let aadhaar_count = responseObject["constituent_details"]["aadhaar_count"].int

            // Create object
                let sendToModel = ConstituentMemberModel()
                sendToModel.male_count = male_count
                sendToModel.female_count = female_count
                sendToModel.voterid_count = voterid_count
                sendToModel.aadhaar_count = aadhaar_count
                sendToModel.member_count = member_count

                successCallback?(sendToModel)
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE Constituency Members URL REQUEST
    func createRequestConstituentMembers(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET TOTAL MEETINGS RESPONSE
    func callAPITotalMeetings(paguthi:String,onSuccess successCallback: ((_ totalMeetings: TotalMeetings) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.totalMeetingsUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["paguthi": paguthi]
        // call API
        self.createRequestConstituentMembers(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Meetings Details" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

              let member_count = responseObject["meeting_details"]["meeting_count"].int
              let requested_count = responseObject["meeting_details"]["requested_count"].int
              let completed_count = responseObject["meeting_details"]["completed_count"].int

              // Create object
              let sendToModel = TotalMeetings()
              sendToModel.meeting_count = member_count
              sendToModel.requested_count = requested_count
              sendToModel.completed_count = completed_count

              successCallback?(sendToModel)
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE Constituency Members URL REQUEST
    func createRequestTotalMeetings(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET TOTAL GREViANCES RESPONSE
    func callAPITotalGreivances(paguthi:String,onSuccess successCallback: ((_ totalGreviancesModel: TotalGreviancesModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.totalGreivancesUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["paguthi": paguthi]
        // call API
        self.createRequestTotalGreivances(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Grievances Details" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

              let grievance_count = responseObject["grievances_details"]["grievance_count"].int
              let enquiry_count = responseObject["grievances_details"]["enquiry_count"].int
              let petition_count = responseObject["grievances_details"]["petition_count"].int
              let processing_count = responseObject["grievances_details"]["processing_count"].int
              let completed_count = responseObject["grievances_details"]["completed_count"].int

              // Create object
              let sendToModel = TotalGreviancesModel()
              sendToModel.grievance_count = grievance_count
              sendToModel.enquiry_count = enquiry_count
              sendToModel.petition_count = petition_count
              sendToModel.processing_count = processing_count
              sendToModel.completed_count = completed_count

              successCallback?(sendToModel)
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE TOTAL GREViANCES URL REQUEST
    func createRequestTotalGreivances(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET CONSTITUENT INTERACTION RESPONSE
    func callAPIConstituentInteraction(paguthi:String,onSuccess successCallback: ((_ constituentInteractionModel: [ConstituentInteractionModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.constituentInteractionUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["paguthi": paguthi]
        // call API
        self.createRequestConstituentIteraction(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Interaction Details" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
            GlobalVariables.shared.interActionCount = responseObject["interaction_count"].int!

              if let responseDict = responseObject["interaction_details"].arrayObject
                {
                      let constituentInteractionModel = responseDict as! [[String:AnyObject]]
                      // Create object
                      var data = [ConstituentInteractionModel]()
                      for item in constituentInteractionModel {
                          let single = ConstituentInteractionModel.build(item)
                          data.append(single)
                      }
                      // Fire callback
                      successCallback?(data)
                 } else {
                      failureCallback?("An error has occured.")
                  }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE CONSTITUENT INTERACTION URL REQUEST
    func createRequestConstituentIteraction(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET LIST CONSTITUENT RESPONSE
    func callAPIConstituentList(paguthi:String, offset:String, rowcount:String, onSuccess successCallback: ((_ listConstiuentModel: [ListConstiuentModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.listConstituentUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["paguthi": paguthi, "offset": offset, "rowcount": rowcount]
        // call API
        self.createRequestConstituentList(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "List constituent" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
            GlobalVariables.shared.constituent_Count =  responseObject["constituent_count"].int!
              if let responseDict = responseObject["constituent_result"].arrayObject
                {
                      let listConstiuent = responseDict as! [[String:AnyObject]]
                      // Create object
                      var data = [ListConstiuentModel]()
                      for item in listConstiuent {
                          let single = ListConstiuentModel.build(item)
                          data.append(single)
                      }
                      // Fire callback
                      successCallback?(data)
                 } else {
                      failureCallback?("An error has occured.")
                  }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE CONSTITUENT INTERACTION URL REQUEST
    func createRequestConstituentList(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET Constituency Members RESPONSE
    func callAPIConstituentDetail(constituent_id:String,onSuccess successCallback: ((_ constituentDetailModel: [ConstituentDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.constituentDetailUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["constituent_id": constituent_id]
        // call API
        self.createRequestConstituentDetail(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Constituent Details" else{
              failureCallback?(responseObject["msg"].string!)
              return
          }
          if let responseDict = responseObject["constituent_details"].arrayObject
            {
                  let constituentDetailModel = responseDict as! [[String:AnyObject]]
                  // Create object
                  var data = [ConstituentDetailModel]()
                  for item in constituentDetailModel {
                      let single = ConstituentDetailModel.build(item)
                      data.append(single)
                  }
                  // Fire callback
                  successCallback?(data)
             } else {
                  failureCallback?("An error has occured.")
              }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE Constituency Members URL REQUEST
    func createRequestConstituentDetail(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET MEETING RESPONSE
    func callAPIMeeting(constituency_id:String,offset:String,rowcount:String, onSuccess successCallback: ((_ meeting: [MeetingModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.constituentmeetingUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["constituent_id": constituency_id]
        // call API
        self.createRequestForMeeting(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Constituent Meetings" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
                        
          if let responseDict = responseObject["meeting_details"].arrayObject
          {
                let meetingModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [MeetingModel]()
                for item in meetingModel {
                    let single = MeetingModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    
    // MARK: MAKE MEETING REQUEST
    func createRequestForMeeting(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET PLANT DONATION RESPONSE
    func callAPIPlant(constituent_id:String, onSuccess successCallback: ((_ plant: [PlantDonationModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.plantDonationUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["constituent_id": constituent_id]
        // call API
        self.createRequestForPlantDonation(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Plant Details" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
            if let responseDict = responseObject["plant_details"].arrayObject
             {
                   let plantDonationModel = responseDict as! [[String:AnyObject]]
                   // Create object
                   var data = [PlantDonationModel]()
                   for item in plantDonationModel {
                       let single = PlantDonationModel.build(item)
                       data.append(single)
                   }
                   // Fire callback
                 successCallback?(data)
              } else {
                   failureCallback?("An error has occured.")
               }
                        
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    
    // MARK: MAKE MEETING REQUEST
    func createRequestForPlantDonation(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET INTERACTION RESPONSE
    func callAPIInteraction(constituent_id:String, onSuccess successCallback: ((_ interactionModel: [InteractionModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.interactionUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["constituent_id": constituent_id]
        // call API
        self.createRequestForInteraction(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Interaction Details" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
            if let responseDict = responseObject["interaction_details"].arrayObject
             {
                   let interactionModel = responseDict as! [[String:AnyObject]]
                   // Create object
                   var data = [InteractionModel]()
                   for item in interactionModel {
                       let single = InteractionModel.build(item)
                       data.append(single)
                   }
                   // Fire callback
                 successCallback?(data)
              } else {
                   failureCallback?("An error has occured.")
               }
                        
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    
    // MARK: MAKE INTERACTION REQUEST
    func createRequestForInteraction(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET CONSTITUENT DOCUMENT RESPONSE
    func callAPIConsDocument(constituent_id:String, onSuccess successCallback: ((_ consDocumentModel: [ConsDocumentModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.constituentDocUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["constituent_id": constituent_id]
        // call API
        self.createRequestForConsDocument(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
            if let responseDict = responseObject["constituent_documents"].arrayObject
             {
                   let consDocumentModel = responseDict as! [[String:AnyObject]]
                   // Create object
                   var data = [ConsDocumentModel]()
                   for item in consDocumentModel {
                       let single = ConsDocumentModel.build(item)
                       data.append(single)
                   }
                   // Fire callback
                 successCallback?(data)
              } else {
                   failureCallback?("An error has occured.")
               }
                        
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    
    // MARK: MAKE DOCUMENT REQUEST
    func createRequestForConsDocument(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET GRIEVANCE DOCUMENT RESPONSE
    func callAPIGriDocument(constituent_id:String, onSuccess successCallback: ((_ griDocumentModel: [GriDocumentModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.grievanceDocUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["constituent_id": constituent_id]
        // call API
        self.createRequestForGriDocument(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
            if let responseDict = responseObject["constituent_documents"].arrayObject
             {
                   let griDocumentModel = responseDict as! [[String:AnyObject]]
                   // Create object
                   var data = [GriDocumentModel]()
                   for item in griDocumentModel {
                       let single = GriDocumentModel.build(item)
                       data.append(single)
                   }
                   // Fire callback
                 successCallback?(data)
              } else {
                   failureCallback?("An error has occured.")
               }
                        
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    
    // MARK: MAKE DOCUMENT REQUEST
    func createRequestForGriDocument(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET CONSTITUENT GRIEVANCE RESPONSE
    func callAPIConstituentGrievances(constituent_id:String, onSuccess successCallback: ((_ constituentGreivancesModel: [ConstituentGreivancesModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.constituentgrievanceUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["constituent_id": constituent_id]
        // call API
        self.createRequestForConstituentGreivances(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
            GlobalVariables.shared.consGreivanceCount = responseObject["grievance_count"].int!
            
            if let responseDict = responseObject["grievance_details"].arrayObject
             {
                   let constituentGreivancesModel = responseDict as! [[String:AnyObject]]
                   // Create object
                   var data = [ConstituentGreivancesModel]()
                   for item in constituentGreivancesModel {
                       let single = ConstituentGreivancesModel.build(item)
                       data.append(single)
                   }
                   // Fire callback
                 successCallback?(data)
              } else {
                   failureCallback?("An error has occured.")
               }
                        
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    
    // MARK: MAKE CONSTITUENT GREIVANCES REQUEST
    func createRequestForConstituentGreivances(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET CONSTITUENT GRIEVANCES MEETING RESPONSE
    func callAPIConstituentGreivancesMeeting(grievance_id:String, onSuccess successCallback: ((_ consGrieMessageModel: [ConsGrieMessageModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.grievancesmeetingUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["grievance_id": grievance_id]
        // call API
        self.createRequestForConstituentGrievancesMeeting(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
                        
            if let responseDict = responseObject["message_details"].arrayObject
             {
                   let consGrieMessageModel = responseDict as! [[String:AnyObject]]
                   // Create object
                   var data = [ConsGrieMessageModel]()
                   for item in consGrieMessageModel {
                       let single = ConsGrieMessageModel.build(item)
                       data.append(single)
                   }
                   // Fire callback
                 successCallback?(data)
              } else {
                   failureCallback?("An error has occured.")
               }
                        
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    
    // MARK: MAKE CONSTITUENT GREIVANCES REQUEST
    func createRequestForConstituentGrievancesMeeting(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET MEETING ALL RESPONSE
    func callAPIMeetingAll(url : String, keyword: String, constituency_id:String, offset:String, rowcount:String, onSuccess successCallback: ((_ meetingAllModel: [MeetingAllModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        let parameters: Parameters
        // Set Parameters
        if keyword == "no"{
              parameters =  ["constituency_id": constituency_id, "offset": offset, "rowcount": rowcount]
        }
        else{
             parameters =  ["constituency_id": constituency_id, "offset": offset, "rowcount": rowcount, "keyword": keyword]
        }
        // call API
        self.createRequestMeetingAll(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
         GlobalVariables.shared.meetingAllCount = responseObject["meeting_count"].int!

          if let responseDict = responseObject["meeting_details"].arrayObject
          {
                let meetingAllModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [MeetingAllModel]()
                for item in meetingAllModel {
                    let single = MeetingAllModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE MEETING ALL URL REQUEST
    func createRequestMeetingAll(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET MEETING ALL DETAIL RESPONSE
    func callAPIMeetingAllDetail(meeting_id : String, onSuccess successCallback: ((_ meetingAllDetailModel: [MeetingAllDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.meetingAllDetailUrl.rawValue
        
        let parameters: Parameters =  ["meeting_id": meeting_id]

        // call API
        self.createRequestMeetingAllDetail(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
          if let responseDict = responseObject["meeting_details"].arrayObject
          {
                let meetingAllDetailModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [MeetingAllDetailModel]()
                for item in meetingAllDetailModel {
                    let single = MeetingAllDetailModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE MEETING ALL DETAIL URL REQUEST
    func createRequestMeetingAllDetail(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET MEETING ALL DETAIL UPDATE RESPONSE
    func callAPIMeetingAllDetailUpdate(meeting_id : String, user_id : String, status : String, onSuccess successCallback: ((_ meetingAllDetailUpdateModel: MeetingAllDetailUpdateModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.meetingAllDetailsUpdateUrl.rawValue
        
        let parameters: Parameters =  ["meeting_id": meeting_id, "user_id": user_id, "status": status]

        // call API
        self.createRequestMeetingAllDetailUpdate(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
         let respMsg = responseObject["msg"].string
         let respStatus = responseObject["status"].string


         // Create object
         let sendToModel = MeetingAllDetailUpdateModel()
         sendToModel.msg = respMsg
         sendToModel.status = respStatus
        
        successCallback?(sendToModel)

            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE MEETING ALL DETAIL UPDATE URL REQUEST
    func createRequestMeetingAllDetailUpdate(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET GREIVANCES ALL RESPONSE
    func callAPIGreivancesAll(url : String, keyword: String, paguthi:String, grievance_type: String, offset:String, rowcount:String, onSuccess successCallback: ((_ constituentGreivancesModel: [ConstituentGreivancesModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        let parameters: Parameters
        // Set Parameters
        if keyword == "no"{
            parameters =  ["paguthi": paguthi, "offset": offset, "rowcount": rowcount, "grievance_type":grievance_type]
        }
        else{
             parameters =  ["paguthi": paguthi, "offset": offset, "rowcount": rowcount, "keyword": keyword, "grievance_type":grievance_type]
        }
        // call API
        self.createRequestGrievancesAll(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
                    
          GlobalVariables.shared.consGreivanceCount = responseObject["grievance_count"].int!

          if let responseDict = responseObject["list_grievances"].arrayObject
          {
                let constituentGreivancesModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [ConstituentGreivancesModel]()
                for item in constituentGreivancesModel {
                    let single = ConstituentGreivancesModel.build(item)
                    data.append(single)
                }
                // Fire callback
                successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE GREIVANCES ALL URL REQUEST
    func createRequestGrievancesAll(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET STAFF RESPONSE
    func callAPIStaff(constituency_id : String, onSuccess successCallback: ((_ staffModel: [StaffModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.staffUrl.rawValue
        
        let parameters: Parameters =  ["constituency_id": constituency_id]

        // call API
        self.createRequestStaff(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
          GlobalVariables.shared.staffCount = responseObject["staff_count"].int!
            
          if let responseDict = responseObject["staff_details"].arrayObject
          {
                let staffModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [StaffModel]()
                for item in staffModel {
                    let single = StaffModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE STAFF URL REQUEST
    func createRequestStaff(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET STAFF DETAIL RESPONSE
    func callAPIStaffDetail(staff_id : String, onSuccess successCallback: ((_ staffDetailModel: [StaffDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.staffDetailUrl.rawValue
        
        let parameters: Parameters =  ["staff_id": staff_id]

        // call API
        self.createRequestStaffDetail(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
                        
          if let responseDict = responseObject["staff_details"].arrayObject
          {
                let staffDetailModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [StaffDetailModel]()
                for item in staffDetailModel {
                    let single = StaffDetailModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE STAFF DETAIL REQUEST
    func createRequestStaffDetail(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET REPORT LIST RESPONSE
    func callAPIStaffReport(url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String, onSuccess successCallback: ((_ reportModel: [ReportModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        let parameters: Parameters
        
        if (From == "status")
        {
            if (keyword == "no")
            {
                parameters = ["from_date": from_date, "to_date": to_date, "status": status, "paguthi": paguthi, "offset": offset, "rowcount": rowcount]
            }
            else
            {
                parameters = ["from_date": from_date,"to_date": to_date,"status": status,"paguthi": paguthi,"offset": offset,"rowcount": rowcount,"keyword":keyword]
            }
        }
        else if (From == "categoery"){
            if (keyword == "no")
            {
                parameters = ["from_date": from_date,"to_date": to_date,"category": category,"offset": offset,"rowcount": rowcount]

            }
            else
            {
                parameters = ["from_date": from_date,"to_date": to_date,"status": status,"paguthi": paguthi,"offset": offset,"rowcount": rowcount,"keyword":keyword]
            }
        }
        else if (From == "subCate"){
            if (keyword == "no")
            {
                parameters = ["from_date": from_date,"to_date": to_date,"sub_category": sub_category,"offset": offset,"rowcount": rowcount]

            }
            else
            {
                parameters = ["from_date": from_date,"to_date": to_date,"status": status,"paguthi": paguthi,"offset": offset,"rowcount": rowcount,"keyword":keyword]
            }
        }
        else {
            if (keyword == "no")
            {
                parameters = ["from_date": from_date,"to_date": to_date,"paguthi": paguthi,"offset": offset,"rowcount": rowcount]

            }
            else
            {
                parameters = ["from_date": from_date,"to_date": to_date,"status": status,"paguthi": paguthi,"offset": offset,"rowcount": rowcount,"keyword":keyword]
            }
        }

        // call API
        self.createRequestStaffReport(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
          GlobalVariables.shared.result_count = responseObject["result_count"].int!

        if (From == "status")
        {
            if let responseDict = responseObject["report_list"].arrayObject
            {
                  let reportModel = responseDict as! [[String:AnyObject]]
                  // Create object
                  var data = [ReportModel]()
                  for item in reportModel {
                      let single = ReportModel.build(item)
                      data.append(single)
                  }
                  // Fire callback
                successCallback?(data)
             } else {
                  failureCallback?("An error has occured.")
              }
        }
        else if (From == "categoery"){
            if let responseDict = responseObject["report_list"].arrayObject
            {
                  let reportModel = responseDict as! [[String:AnyObject]]
                  // Create object
                  var data = [ReportModel]()
                  for item in reportModel {
                      let single = ReportModel.build(item)
                      data.append(single)
                  }
                  // Fire callback
                successCallback?(data)
             } else {
                  failureCallback?("An error has occured.")
              }
        }
        else if (From == "subCate"){
            if let responseDict = responseObject["report_list"].arrayObject
            {
                  let reportModel = responseDict as! [[String:AnyObject]]
                  // Create object
                  var data = [ReportModel]()
                  for item in reportModel {
                      let single = ReportModel.build(item)
                      data.append(single)
                  }
                  // Fire callback
                successCallback?(data)
             } else {
                  failureCallback?("An error has occured.")
              }
        }
        else {
            if let responseDict = responseObject["report_list"].arrayObject
            {
                  let reportModel = responseDict as! [[String:AnyObject]]
                  // Create object
                  var data = [ReportModel]()
                  for item in reportModel {
                      let single = ReportModel.build(item)
                      data.append(single)
                  }
                  // Fire callback
                successCallback?(data)
             } else {
                  failureCallback?("An error has occured.")
              }
        }
                        
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE STAFF DETAIL REQUEST
    func createRequestStaffReport(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET CATEGOERY RESPONSE
    func callAPICategoery(user_id:String,onSuccess successCallback: ((_ caategoeryModel: [CaategoeryModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.categoeryUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id]
        // call API
        self.createRequestCategoery(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        if let responseDict = responseObject["category_details"].arrayObject
          {
                let caategoeryModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [CaategoeryModel]()
                for item in caategoeryModel {
                    let single = CaategoeryModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE CATEGOERY REQUEST
    func createRequestCategoery(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
    //MARK: GET SUB CATEGOERY RESPONSE
    func callAPISubCategoery(user_id:String,onSuccess successCallback: ((_ subCategoeryModel: [SubCategoeryModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.SubcategoeryUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id]
        // call API
        self.createRequestSubCategoery(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
        guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        if let responseDict = responseObject["sub_category_details"].arrayObject
           {
                let subCategoeryModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [SubCategoeryModel]()
                for item in subCategoeryModel {
                    let single = SubCategoeryModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE SUB CATEGOERY REQUEST
    func createRequestSubCategoery(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
    
}
