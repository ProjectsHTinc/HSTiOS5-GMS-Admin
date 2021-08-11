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
          case versionUrl = "apiandroid/version_check/"
          case loginUrl = "apiandroid/login/"
          case MobileloginUrl = "apiandroid/mobile_login/"
          case otpUrl = "apiandroid/mobile_verify/"
        
//          case mobileloginUrl = "apiandroid/moilelogin/"
          case forgotPasswordUrl = "apiandroid/forgotPassword"
          case searchUrl = "apiandroid/dashBoard_searchnew"
          case dashUrl = "apiandroid/dashBoard"
          case paguthiUrl = "apiandroid/listPaguthi"
          case officeUrl = "apiandroid/list_office"
          case constituentMembers = "apiandroid/widgets_members"
          case totalMeetingsUrl = "apiandroid/widgets_meetings"
          case totalGreivancesUrl = "apiandroid/widgets_grievances"
          case constituentInteractionUrl = "apiandroid/widgets_interactions"
          case listConstituentUrl = "apiandroid/listConstituentnew"
          case constituentDetailUrl = "apiandroid/constituentDetails"
          case constituentmeetingUrl = "apiandroid/constituentMeetings"
          case plantDonationUrl = "apiandroid/constituentPlant"
          case interactionUrl = "apiandroid/constituentInteraction"
          case constituentDocUrl = "apiandroid/constituentDocuments"
          case grievanceDocUrl = "apiandroid/constituentgrvDocuments"
          case constituentgrievanceUrl = "apiandroid/constituentGrievances"
          case grievancesmeetingUrl = "apiandroid/grievanceMessage"
          case meetingAllUrl = "apiandroid/meetingRequestnew"
          case meetingAllDetailUrl = "apiandroid/meetingDetails"
          case meetingAllDetailsUpdateUrl = "apiandroid/meetingUpdate"
          case staffUrl = "apiandroid/listStaff"
          case staffDetailUrl = "apiandroid/staffDetails"
          case categoeryUrl = "apiandroid/activeCategory"
          case SubcategoeryUrl = "apiandroid/activeSubcategory"
          case staffreportUrl = "apiandroid/reportStaff"
          case profileDetailsUrl = "apiandroid/profileDetails"
          case profilePicUrl = "apiandroid/profilePictureUpload/"
          case profileUpdateUrl = "apiandroid/profileUpdate"
          case changePasswordUrl = "apiandroid/changePassword"
          case footFallUrl = "apiandroid/widgets_footfall"
          case volounteerUrl = "apiandroid/widgets_volunteer"
          case greetingCountUrl = "apiandroid/widgets_greetings"
          case vedioCountUrl = "apiandroid/widgets_videos"
          case festivalReportUrl = "apiandroid/getFestivals"
          case seekerNameUrl = "apiandroid/activeSeeker"
          case birthdayYearUrl = "apiandroid/getBirthdayyear"
        
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
        
    func callAPIcheckConstituent(constituency_code:String, onSuccess successCallback: ((_ constituencyName: [CheckConstituentModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = "https://happysanz.in/gms/apiandroid/chk_constituency_code/"
        // Set Parameters
        let parameters: Parameters =  ["constituency_code":constituency_code]
        // call API
        self.createRequestForLogin(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
            guard let msg = responseObject["msg"].string, msg == "Login Successfully" else{
                failureCallback?(responseObject["msg"].string!)
                return
          }
            if let dynamicDB = responseObject["dynamic_db"]["dynamic_db"].string
            {
                UserDefaults.standard.setValue(dynamicDB, forKey: "dynamicDBKey")
                GlobalVariables.shared.dynamic_db = responseObject["dynamic_db"]["dynamic_db"].string!
            }
           
            if let responseDict = responseObject["userData"].arrayObject
              {
                    let clientUrlModel = responseDict as! [[String:AnyObject]]
                    // Create object
                    var data = [CheckConstituentModel]()
                    for item in clientUrlModel {
                        let single = CheckConstituentModel.build(item)
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
    
        
    //MARK: GET CLIENT URL RESPONSE
    func callAPIGetClientUrl(select_ID:String,onSuccess successCallback: ((_ client_url: [ClientUrlModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.clientUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["id": select_ID,"dynamic_db":"sanzhapp_191928"]
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
    func callAPILogin(user_name:String, password:String,dynamic_db:String, onSuccess successCallback: ((_ login: LoginModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.loginUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_name": user_name,"password": password,"device_id":GlobalVariables.shared.Devicetoken ,"mobile_type":Globals.mobileType,"dynamic_db":dynamic_db]
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

    
    func callAPIOTP(mobile_no:String, otp:String,dynamic_db:String, onSuccess successCallback: ((_ otp: [OTPModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.otpUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["mobile_no": mobile_no,"otp": otp, "device_id": GlobalVariables.shared.Devicetoken, "mobile_type": Globals.mobileType,"dynamic_db":dynamic_db]
        // call API
        self.createRequestForLogin(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "details found" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
          GlobalVariables.shared.userCount = responseObject["user_count"].int!
            
          if let responseDict = responseObject["user_details"].arrayObject
          {
                let otpModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [OTPModel]()
                for item in otpModel {
                    let single = OTPModel.build(item)
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
    
    func callAPIMobileLogin(user_name:String,dynamic_db:String, onSuccess successCallback: ((_ login: MobileLoginModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.MobileloginUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["mobile_no": user_name,"dynamic_db":dynamic_db]
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

            let sendToModel = MobileLoginModel()
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
        let parameters: Parameters =  ["user_name": user_name,"dynamic_db":"sanzhapp_191928"]
        // call API
        self.createRequestForLogin(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "success" else{
              failureCallback?(responseObject["status"].string!)
              return
        }
          
            let status = responseObject["status"].string
            let msgRes = responseObject["msg"].string
            let sendToModel = ForgotPasswordModel()
            sendToModel.status = status
            sendToModel.msg = msgRes
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
          guard let status = responseObject["status"].string, status == "Success" else{
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
    
    
    func callAPIReportFestival(dynamic_db:String,onSuccess successCallback: ((_ paguthi: [ReportFestivalModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.festivalReportUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db]
        // call API
        self.createRequestPaguthi(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Festivals" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        if let responseDict = responseObject["festivals"].arrayObject
          {
                let officeModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [ReportFestivalModel]()
                for item in officeModel {
                    let single = ReportFestivalModel.build(item)
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
    
    func callAPIOffice(constituency_id:String,dynamic_db:String,onSuccess successCallback: ((_ paguthi: [OfficeModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.officeUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["constituency_id": constituency_id,"dynamic_db":dynamic_db]
        // call API
        self.createRequestPaguthi(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "List Office" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        if let responseDict = responseObject["list_details"].arrayObject
          {
                let officeModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [OfficeModel]()
                for item in officeModel {
                    let single = OfficeModel.build(item)
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
    
    //MARK: GET PAGUTHI URL RESPONSE
    func callAPIPaguthi(constituency_id:String,dynamic_db:String,onSuccess successCallback: ((_ paguthi: [AreaModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.paguthiUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["constituency_id": constituency_id,"dynamic_db":dynamic_db]
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

    func callAPIConstituentMembers(paguthi:String,dynamic_db:String,from_date:String,to_date:String,onSuccess successCallback: ((_ constituentInteractionModel: [ConstituentMemberModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.constituentMembers.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"paguthi": paguthi,"from_date":from_date,"to_date":to_date]
        // call API
        self.createRequestConstituentMembers(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Constituent Details" else {
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
//            GlobalVariables.shared.interActionCount = responseObject["interaction_count"].int!

              if let responseDict = responseObject["constituent_details"].arrayObject
                {
                      let constituentMemberModel = responseDict as! [[String:AnyObject]]
                      // Create object
                      var data = [ConstituentMemberModel]()
                      for item in constituentMemberModel {
                          let single = ConstituentMemberModel.build(item)
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
    func callAPITotalMeetings(dynamic_db:String,paguthi:String,from_date:String,to_date:String,onSuccess successCallback: ((_ totalMeetings: TotalMeetings) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.totalMeetingsUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"paguthi_id": paguthi,"from_date":from_date,"to_date":to_date]
        // call API
        self.createRequestConstituentMembers(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Meetings Details" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
              let total_meeting = responseObject["meeting_details"]["total_meeting"].string
              let request_count = responseObject["meeting_details"]["request_count"].string
              let request_count_percentage = responseObject["meeting_details"]["request_count_percentage"].string
              let complete_count = responseObject["meeting_details"]["complete_count"].string
              let complete_count_percentage = responseObject["meeting_details"]["complete_count_percentage"].string
            
              // Create object
              let sendToModel = TotalMeetings()
              sendToModel.total_meeting = total_meeting
              sendToModel.request_count_percentage = request_count_percentage
              sendToModel.request_count = request_count
              sendToModel.complete_count = complete_count
              sendToModel.complete_count_percentage = complete_count_percentage

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
    
    func callAPIFootfall(dynamic_db:String,paguthi:String,from_date:String,to_date:String,onSuccess successCallback: ((_ totalGreviancesModel: FootFallModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.footFallUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"paguthi_id": paguthi,"from_date":from_date,"to_date":to_date]
        // call API
        self.createRequestToFootFall(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Footfall Details" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

            let total_footfall_cnt = responseObject["footfall_details"]["total_footfall_cnt"].int
            let unique_footfall_cnt = responseObject["footfall_details"]["unique_footfall_cnt"].int
            let repeated_footfall_cnt_presntage = responseObject["footfall_details"]["repeated_footfall_cnt_presntage"].string
            let repeated_footfall_cnt = responseObject["footfall_details"]["repeated_footfall_cnt"].int
            let unique_footfall_cnt_presntage = responseObject["footfall_details"]["unique_footfall_cnt_presntage"].string
            let total_unique_footfall_cnt = responseObject["footfall_details"]["total_unique_footfall_cnt"].int
            let other_unique_footfall_cnt = responseObject["footfall_details"]["other_unique_footfall_cnt"].int
            let cons_unique_footfall_cnt = responseObject["footfall_details"]["cons_unique_footfall_cnt"].int
            let cons_unique_footfall_cnt_presntage = responseObject["footfall_details"]["cons_unique_footfall_cnt_presntage"].string
            let other_unique_footfall_cnt_presntage = responseObject["footfall_details"]["other_unique_footfall_cnt_presntage"].string
            let constituency_cnt = responseObject["footfall_details"]["constituency_cnt"].int
            let cons_unique_cnt = responseObject["footfall_details"]["cons_unique_cnt"].int
            let cons_repeated_cnt = responseObject["footfall_details"]["cons_repeated_cnt"].int
            let cons_unique_cnt_presntage = responseObject["footfall_details"]["cons_unique_cnt_presntage"].string
            let cons_repeated_cnt_presntage = responseObject["footfall_details"]["cons_repeated_cnt_presntage"].string
            let other_cnt = responseObject["footfall_details"]["other_cnt"].int
            let other_unique_cnt = responseObject["footfall_details"]["other_unique_cnt"].int
            let other_repeated_cnt = responseObject["footfall_details"]["other_repeated_cnt"].int
            let other_unique_cnt_presntage = responseObject["footfall_details"]["other_unique_cnt_presntage"].string
            let other_repeated_cnt_presntage = responseObject["footfall_details"]["other_repeated_cnt_presntage"].string
            
              // Create object
            let sendToModel = FootFallModel()
            sendToModel.total_footfall_cnt = total_footfall_cnt
            sendToModel.unique_footfall_cnt = unique_footfall_cnt
            sendToModel.repeated_footfall_cnt = repeated_footfall_cnt
            sendToModel.unique_footfall_cnt_presntage = unique_footfall_cnt_presntage
            sendToModel.repeated_footfall_cnt_presntage = repeated_footfall_cnt_presntage
            sendToModel.total_unique_footfall_cnt = total_unique_footfall_cnt
            sendToModel.other_unique_footfall_cnt = other_unique_footfall_cnt
            sendToModel.cons_unique_footfall_cnt = cons_unique_footfall_cnt
            sendToModel.cons_unique_footfall_cnt_presntage = cons_unique_footfall_cnt_presntage
            sendToModel.other_unique_footfall_cnt_presntage = other_unique_footfall_cnt_presntage
            sendToModel.constituency_cnt = constituency_cnt
            sendToModel.cons_unique_cnt = cons_unique_cnt
            sendToModel.cons_repeated_cnt = cons_repeated_cnt
            sendToModel.cons_unique_cnt_presntage = cons_unique_cnt_presntage
            sendToModel.cons_repeated_cnt_presntage = cons_repeated_cnt_presntage
            sendToModel.other_cnt = other_cnt
            sendToModel.other_unique_cnt = other_unique_cnt
            sendToModel.other_repeated_cnt = other_repeated_cnt
            sendToModel.other_unique_cnt_presntage = other_unique_cnt_presntage
            sendToModel.other_repeated_cnt_presntage = other_repeated_cnt_presntage

              successCallback?(sendToModel)
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE TOTAL GREViANCES URL REQUEST
    func createRequestToFootFall(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
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
    func callAPITotalGreivances(paguthi:String,from_date:String,dynamic_db:String,to_date:String,onSuccess successCallback: ((_ totalGreviancesModel: TotalGreviancesModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.totalGreivancesUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"paguthi": paguthi,"from_date":from_date,"to_date":to_date]
        // call API
        self.createRequestTotalGreivances(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Grievances Details" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

            let tot_grive_count = responseObject["tot_grive_count"].int
            let enquiry_count = responseObject["enquiry_count"].string
            let petition_count = responseObject["petition_count"].string
            let civic_petition_count = responseObject["civic_petition_count"].string
            let online_petition_count = responseObject["online_petition_count"].string
            let petition_completed = responseObject["petition_status"]["petition_completed"].string
            let petition_pending_percentage = responseObject["petition_status"]["petition_pending_percentage"].string
            let petition_completed_percentage = responseObject["petition_status"]["petition_completed_percentage"].string
            let petition_rejected = responseObject["petition_status"]["petition_rejected"].string
            let petition_pending = responseObject["petition_status"]["petition_pending"].string
            let petition_rejected_percentage = responseObject["petition_status"]["petition_rejected_percentage"].string
            let no_of_online = responseObject["petition_list"]["no_of_online"].string
            let no_of_online_percentage = responseObject["petition_list"]["no_of_online_percentage"].string
            let no_of_civic = responseObject["petition_list"]["no_of_civic"].string
            let no_of_civic_percentage = responseObject["petition_list"]["no_of_civic_percentage"].string
            let no_of_onlineEQ = responseObject["enquiry_list"]["no_of_online"].string
            let no_of_online_percentageEQ = responseObject["enquiry_list"]["no_of_online_percentage"].string
            let no_of_civicEQ = responseObject["enquiry_list"]["no_of_civic"].string
            let no_of_civic_percentageEQ = responseObject["enquiry_list"]["no_of_civic_percentage"].string
            let petition_pendingCivic = responseObject["civic_petition_status"]["petition_pending"].string
            let petition_pending_percentageCivic = responseObject["civic_petition_status"]["petition_pending_percentage"].string
            let petition_completedCivic = responseObject["civic_petition_status"]["petition_completed"].string
            let petition_completed_percentageCivic = responseObject["civic_petition_status"]["petition_completed_percentage"].string
            let petition_rejectedCivic = responseObject["civic_petition_status"]["petition_rejected"].string
            let petition_rejected_percentageCivic = responseObject["civic_petition_status"]["petition_rejected_percentage"].string
            let petition_pendingOnline = responseObject["online_petition_status"]["petition_pending"].string
            let petition_pending_percentageOnline = responseObject["online_petition_status"]["petition_pending_percentage"].string
            let petition_completedOnline = responseObject["online_petition_status"]["petition_completed"].string
            let no_of_online_percentageOnline = responseObject["online_petition_status"]["petition_completed_percentage"].string
            let petition_rejectedOnline = responseObject["online_petition_status"]["petition_rejected"].string
            let petition_rejected_percentageOnline = responseObject["online_petition_status"]["petition_rejected_percentage"].string
            
              // Create object
            let sendToModel = TotalGreviancesModel()
            sendToModel.tot_grive_count = tot_grive_count
            sendToModel.enquiry_count = enquiry_count
            sendToModel.petition_count = petition_count
//            sendToModel.processing_count = processing_count
//            sendToModel.completed_count = completed_count
            sendToModel.civic_petition_count = civic_petition_count
            sendToModel.online_petition_count = online_petition_count
            
            sendToModel.petition_rejected_percentageOnline = petition_rejected_percentageOnline
            sendToModel.petition_pendingOnline = petition_pendingOnline
            sendToModel.petition_pending_percentageOnline = petition_pending_percentageOnline
            sendToModel.no_of_online_percentageOnline = no_of_online_percentageOnline
            sendToModel.petition_completedOnline = petition_completedOnline
            sendToModel.petition_rejectedOnline = petition_rejectedOnline
            
            sendToModel.petition_rejected_percentageCivic = petition_rejected_percentageCivic
            sendToModel.petition_rejectedCivic = petition_rejectedCivic
            sendToModel.petition_completed_percentageCivic = petition_completed_percentageCivic
            sendToModel.petition_completedCivic = petition_completedCivic
            sendToModel.petition_pending_percentageCivic = petition_pending_percentageCivic
            sendToModel.petition_pendingCivic = petition_pendingCivic

            sendToModel.no_of_civic_percentageEQ = no_of_civic_percentageEQ
            sendToModel.no_of_civicEQ = no_of_civicEQ
            sendToModel.no_of_online_percentageEQ = no_of_online_percentageEQ
            sendToModel.no_of_onlineEQ = no_of_onlineEQ
          
            sendToModel.no_of_online = no_of_online
            sendToModel.no_of_online_percentage = no_of_online_percentage
            sendToModel.no_of_civic = no_of_civic
            sendToModel.no_of_civic_percentage = no_of_civic_percentage

            sendToModel.petition_pending_percentage = petition_pending_percentage
            sendToModel.petition_completed_percentage = petition_completed_percentage
            sendToModel.petition_pending = petition_pending
            sendToModel.petition_rejected_percentage = petition_rejected_percentage
            sendToModel.petition_rejected = petition_rejected
            sendToModel.petition_completed = petition_completed

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
    
    func callAPIVolounteer(paguthi:String,from_date:String,dynamic_db:String,to_date:String,onSuccess successCallback: ((_ volounteerModel: VolounteerModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.volounteerUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"paguthi_id": paguthi,"from_date":from_date,"to_date":to_date]
        // call API
        self.createRequestVolounteer(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Volunter Details" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

              let total_volunteer = responseObject["volunteer_details"]["total_volunteer"].string
              let no_of_volunteer = responseObject["volunteer_details"]["no_of_volunteer"].string
              let volunteer_percentage = responseObject["volunteer_details"]["volunteer_percentage"].string
              let no_of_nonvolunteer = responseObject["volunteer_details`"]["no_of_nonvolunteer"].string
              let nonvolunteer_percentage = responseObject["volunteer_details"]["nonvolunteer_percentage"].string
            
              // Create object
              let sendToModel = VolounteerModel()
              sendToModel.total_volunteer = total_volunteer
              sendToModel.no_of_volunteer = no_of_volunteer
              sendToModel.volunteer_percentage = volunteer_percentage
              sendToModel.no_of_nonvolunteer = no_of_nonvolunteer
              sendToModel.nonvolunteer_percentage = nonvolunteer_percentage

              successCallback?(sendToModel)
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE Constituency Members URL REQUEST
    func createRequestVolounteer(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
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
    
    func callAPIGreetingCount(paguthi:String,from_date:String,to_date:String,dynamic_db:String,onSuccess successCallback: ((_ greetingCountModel: [GreetingCountModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.greetingCountUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"paguthi": paguthi,"from_date":from_date,"to_date":to_date]
        // call API
        self.createRequestConstituentMembers(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
            
            GlobalVariables.shared.birthday_wish_count = responseObject["greetings_details"]["birthday_wish_count"].string!
            GlobalVariables.shared.festival_wishes_count = responseObject["greetings_details"]["festival_wishes_count"].string!
            GlobalVariables.shared.total_greetings = responseObject["greetings_details"]["total_greetings"].int!
            
          guard let msg = responseObject["msg"].string, msg == "Greetings Details" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
            if let responseDict = responseObject["festival_greetings_details"].arrayObject
                {
                      let greetingCountModel = responseDict as! [[String:AnyObject]]
                      // Create object
                      var data = [GreetingCountModel]()
                      for item in greetingCountModel {
                          let single = GreetingCountModel.build(item)
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
    func createRequestGreetingCount(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
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
     
    func callAPIVedioCount(paguthi:String,from_date:String,to_date:String,dynamic_db:String,onSuccess successCallback: ((_ vedioCountModel: [VedioCountModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.vedioCountUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"paguthi": paguthi,"from_date":from_date,"to_date":to_date]
        // call API
        self.createRequestConstituentMembers(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Video Details" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
           GlobalVariables.shared.vedioCount = responseObject["video_count"].int!

              if let responseDict = responseObject["video_list"].arrayObject
                {
                      let vedioCountModel = responseDict as! [[String:AnyObject]]
                      // Create object
                      var data = [VedioCountModel]()
                      for item in vedioCountModel {
                          let single = VedioCountModel.build(item)
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
    func createRequestVedioCount(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
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
    func callAPIConstituentInteraction(dynamic_db:String,paguthi:String,onSuccess successCallback: ((_ constituentInteractionModel: [ConstituentInteractionModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.constituentInteractionUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"paguthi": paguthi]
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
    func callAPIConstituentList(dynamic_db:String,url:String,Keyword:String,paguthi:String, offset:String, rowcount:String, onSuccess successCallback: ((_ listConstiuentModel: [ListConstiuentModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        let parameters: Parameters
       
        // Set Parameters
        if Keyword == "no"{
            parameters =  ["dynamic_db":dynamic_db,"paguthi": paguthi, "offset": offset, "rowcount": "50"]
        }
        else
        {
            parameters =  ["dynamic_db":dynamic_db,"paguthi": paguthi, "offset": offset, "rowcount": "50","keyword":Keyword]
        }
        print(parameters)
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
    func callAPIConstituentDetail(dynamic_db:String,constituent_id:String,onSuccess successCallback: ((_ constituentDetailModel: [ConstituentDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.constituentDetailUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"constituent_id": constituent_id]
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
    func callAPIMeeting(dynamic_db:String,constituency_id:String,offset:String,rowcount:String, onSuccess successCallback: ((_ meeting: [MeetingModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.constituentmeetingUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"constituent_id": constituency_id,]
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
    func callAPIPlant(dynamic_db:String,constituent_id:String, onSuccess successCallback: ((_ plant: [PlantDonationModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.plantDonationUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"constituent_id": constituent_id]
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
    func callAPIInteraction(dynamic_db:String,constituent_id:String, onSuccess successCallback: ((_ interactionModel: [InteractionModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.interactionUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"constituent_id": constituent_id]
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
    func callAPIConsDocument(dynamic_db:String,constituent_id:String, onSuccess successCallback: ((_ consDocumentModel: [ConsDocumentModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.constituentDocUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"constituent_id": constituent_id]
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
    func callAPIGriDocument(dynamic_db:String,constituent_id:String, onSuccess successCallback: ((_ griDocumentModel: [GriDocumentModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.grievanceDocUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"constituent_id": constituent_id]
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
    func callAPIConstituentGrievances(dynamic_db:String,constituent_id:String, onSuccess successCallback: ((_ constituentGreivancesModel: [ConstituentGreivancesModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.constituentgrievanceUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"constituent_id": constituent_id]
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
    func callAPIConstituentGreivancesMeeting(dynamic_db:String,grievance_id:String, onSuccess successCallback: ((_ consGrieMessageModel: [ConsGrieMessageModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.grievancesmeetingUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"grievance_id": grievance_id]
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
    func callAPIMeetingAll(dynamic_db:String,url : String, keyword: String, constituency_id:String, offset:String, rowcount:String, onSuccess successCallback: ((_ meetingAllModel: [MeetingAllModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        let parameters: Parameters
        // Set Parameters
        if keyword == "no"{
              parameters =  ["dynamic_db":dynamic_db,"constituency_id": constituency_id, "offset": offset, "rowcount": rowcount]
        }
        else{
             parameters =  ["dynamic_db":dynamic_db,"constituency_id": constituency_id, "offset": offset, "rowcount": rowcount, "keyword": keyword]
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
    func callAPIMeetingAllDetail(dynamic_db:String,meeting_id : String, onSuccess successCallback: ((_ meetingAllDetailModel: [MeetingAllDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.meetingAllDetailUrl.rawValue
        
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"meeting_id": meeting_id]

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
    func callAPIMeetingAllDetailUpdate(dynamic_db:String,meeting_id : String, user_id : String, status : String, onSuccess successCallback: ((_ meetingAllDetailUpdateModel: MeetingAllDetailUpdateModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.meetingAllDetailsUpdateUrl.rawValue
        
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"meeting_id": meeting_id, "user_id": user_id, "status": status]

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
    func callAPIGreivancesAll(dynamic_db:String,url : String, keyword: String, paguthi:String, grievance_type: String, offset:String, rowcount:String, onSuccess successCallback: ((_ constituentGreivancesModel: [ConstituentGreivancesModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        let parameters: Parameters
        // Set Parameters
        if keyword == "no"{
            parameters =  ["dynamic_db":dynamic_db,"paguthi": paguthi, "offset": offset, "rowcount": rowcount, "grievance_type":grievance_type]
        }
        else{
             parameters =  ["dynamic_db":dynamic_db,"paguthi": paguthi, "offset": offset, "rowcount": rowcount, "keyword": keyword, "grievance_type":grievance_type]
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
    func callAPIStaff(dynamic_db:String,constituency_id : String, onSuccess successCallback: ((_ staffModel: [StaffModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.staffUrl.rawValue
        
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"constituency_id": constituency_id]

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
    func callAPIStaffDetail(dynamic_db:String,staff_id : String, onSuccess successCallback: ((_ staffDetailModel: [StaffDetailModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.staffDetailUrl.rawValue
        
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"staff_id": staff_id]

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
                failureCallback?("An error has occured")
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
    
    func callAPIReportGrievanceList(dynamic_db:String,url : String,seeker_type_id: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,office:String,onSuccess successCallback: ((_ caategoeryModel: [ReportGrievanceListModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        // Set Parameters
        let parameters: Parameters = ["dynamic_db":dynamic_db,"from_date": from_date,"to_date": to_date,"status": status,"paguthi":paguthi,"offset": offset,"rowcount": rowcount,"keyword":keyword,"office":office,"grievance_type_id":category,"seeker_type_id":seeker_type_id,"sub_category":sub_category]
        // call API
        self.createRequestCategoery(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        if let responseDict = responseObject["grievance_report"].arrayObject
          {
                let caategoeryModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [ReportGrievanceListModel]()
                for item in caategoeryModel {
                    let single = ReportGrievanceListModel.build(item)
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
    
    func callAPIReportMeetingList(dynamic_db:String,url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,office:String,onSuccess successCallback: ((_ caategoeryModel: [ReportMeetingListModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        // Set Parameters
        let parameters: Parameters = ["dynamic_db":dynamic_db,"from_date": from_date,"to_date": to_date,"status": "","paguthi": "","offset": offset,"rowcount": rowcount,"keyword":keyword,"office":""]
        // call API
        self.createRequestCategoery(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        if let responseDict = responseObject["report_list"].arrayObject
          {
                let caategoeryModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [ReportMeetingListModel]()
                for item in caategoeryModel {
                    let single = ReportMeetingListModel.build(item)
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
    
    //MARK: GET REPORT LIST RESPONSE
    func callAPIStaffReport
    (dynamic_db:String,url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,office:String, onSuccess successCallback: ((_ reportModel: [ReportModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        let parameters: Parameters
        
        if (From == "status")
        {
            if (keyword == "no")
            {
                parameters = ["dynamic_db":dynamic_db,"from_date": from_date, "to_date": to_date, "status": status, "paguthi": paguthi, "offset": offset, "rowcount": rowcount,"office":office]
            }
            else
            {
                parameters = ["dynamic_db":dynamic_db,"from_date": from_date,"to_date": to_date,"status": status,"paguthi": paguthi,"offset": offset,"rowcount": rowcount,"keyword":keyword,"office":office]
            }
        }
        
        
        else if (From == "meeting")
        {
            if (keyword == "no")
            {
                parameters = ["dynamic_db":dynamic_db,"from_date": from_date,"to_date": to_date,"status": "","paguthi": "","offset": offset,"rowcount": rowcount,"keyword":keyword,"office":""]
            }
            else
            {
                parameters = ["dynamic_db":dynamic_db,"from_date": from_date,"to_date": to_date,"status": "","paguthi": "","offset": offset,"rowcount": rowcount,"keyword":keyword,"office":""]
            }
        }
        
        else if (From == "categoery"){
            if (keyword == "no")
            {
                parameters = ["dynamic_db":dynamic_db,"from_date": from_date,"to_date": to_date,"category": category,"offset": offset,"rowcount": rowcount]

            }
            else
            {
                parameters = ["dynamic_db":dynamic_db,"from_date": from_date,"to_date": to_date,"category": category,"offset": offset,"rowcount": rowcount,"keyword":keyword]
            }
        }
        else if (From == "subCate"){
            if (keyword == "no")
            {
                parameters = ["dynamic_db":dynamic_db,"from_date": from_date,"to_date": to_date,"sub_category": sub_category,"offset": offset,"rowcount": rowcount]

            }
            else
            {
                parameters = ["dynamic_db":dynamic_db,"from_date": from_date,"to_date": to_date,"sub_category": sub_category,"offset": offset,"rowcount": rowcount,"keyword":keyword]
            }
        }
        else {
            if (keyword == "no")
            {
                parameters = ["dynamic_db":dynamic_db,"from_date": from_date,"to_date": to_date,"paguthi": paguthi,"offset": offset,"rowcount": rowcount]

            }
            else
            {
                parameters = ["dynamic_db":dynamic_db,"from_date": from_date,"to_date": to_date,"paguthi": paguthi,"offset": offset,"rowcount": rowcount,"keyword":keyword]
            }
        }

        // call API
        self.createRequestStaffReport(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Status based report" || msg == "Meetings report"  else{
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
        else if (From == "meeting"){
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
    func callAPICategoery(dynamic_db:String,user_id:String,onSuccess successCallback: ((_ caategoeryModel: [CaategoeryModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.categoeryUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"user_id": user_id]
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
    
    func callAPISeekerType(dynamic_db:String,user_id:String,onSuccess successCallback: ((_ caategoeryModel: [SeekerTypeModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.seekerNameUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"user_id": user_id]
        // call API
        self.createRequestCategoery(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        if let responseDict = responseObject["seeker_details"].arrayObject
          {
                let caategoeryModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [SeekerTypeModel]()
                for item in caategoeryModel {
                    let single = SeekerTypeModel.build(item)
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
    
    func callAPIBirthdayYear(dynamic_db:String,onSuccess successCallback: ((_ caategoeryModel: [BirthdayYearModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.birthdayYearUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db]
        // call API
        self.createRequestCategoery(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        if let responseDict = responseObject["birthday_year"].arrayObject
          {
                let caategoeryModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [BirthdayYearModel]()
                for item in caategoeryModel {
                    let single = BirthdayYearModel.build(item)
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
    func callAPISubCategoery(dynamic_db:String,user_id:String,onSuccess successCallback: ((_ subCategoeryModel: [SubCategoeryModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.SubcategoeryUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"user_id": user_id]
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
    
    //MARK: GET REPORT MEETING ALL RESPONSE
    func callAPIReportMeeting(dynamic_db:String,url : String, keyword: String, from_date:String, to_date:String, offset:String, rowcount:String, onSuccess successCallback: ((_ meetingAllModel: [MeetingAllModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        let parameters: Parameters
        // Set Parameters
        if keyword == "no"{
              parameters =  ["dynamic_db":dynamic_db,"from_date": from_date, "to_date": to_date, "offset": offset, "rowcount": rowcount]
        }
        else{
             parameters =  ["dynamic_db":dynamic_db,"from_date": from_date, "to_date": to_date, "offset": offset, "rowcount": rowcount, "keyword": keyword]
        }
        // call API
        self.createRequestReportMeeting(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          guard let msg = responseObject["status"].string, msg == "Meetings report" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
         GlobalVariables.shared.meetingAllCount = responseObject["result_count"].int!
          if let responseDict = responseObject["report_list"].arrayObject
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
    
    // MARK: MAKE REPORT MEETING ALL URL REQUEST
    func createRequestReportMeeting(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
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
    
    //MARK: GET REPORT STAFF RESPONSE
    func callAPIReportStaff(dynamic_db:String,from_date:String, to_date:String, onSuccess successCallback: ((_ reportStaffModel: [ReportStaffModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.staffreportUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"from_date": from_date, "to_date": to_date]
        // call API
        self.createReportStaff(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        GlobalVariables.shared.meetingAllCount = responseObject["result_count"].int!

            
        if let responseDict = responseObject["staff_report"].arrayObject
          {
                let reportStaffModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [ReportStaffModel]()
                for item in reportStaffModel {
                    let single = ReportStaffModel.build(item)
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
    func createReportStaff(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
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
    
    //MARK: GET REPORT BIRTHDAY ALL RESPONSE
    func callAPIReportBirthday(url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,dynamic_db:String,office:String, onSuccess successCallback: ((_ reportBirthdayModel: [ReportBirthdayModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        let parameters: Parameters
        // Set Parameters

        if keyword == "no"{
              parameters = ["dynamic_db":dynamic_db,"from_year": from_date,"to_year": to_date,"paguthi": "","offset": offset,"rowcount": rowcount,"keyword":keyword,"office":"","select_month":status]
        }
        else{
             parameters =  ["dynamic_db":dynamic_db,"from_year": from_date,"to_year": to_date,"paguthi": "","offset": offset,"rowcount": rowcount,"keyword":keyword,"office":"","select_month":status]
        }
        // call API
        self.createRequestReportBirthday(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
         GlobalVariables.shared.meetingAllCount = responseObject["result_count"].int!

          if let responseDict = responseObject["birthday_report"].arrayObject
          {
                let reportBirthdayModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [ReportBirthdayModel]()
                for item in reportBirthdayModel {
                    let single = ReportBirthdayModel.build(item)
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
    
    
    func callAPIReportStaffList(url:String,from_date: String,to_date: String,dynamic_db:String, onSuccess successCallback: ((_ reportBirthdayModel: [ReportStaffListModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        
        let parameters: Parameters = ["dynamic_db":dynamic_db,"from_date": "","to_date":""]
        // call API
        self.createRequestReportBirthday(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
         GlobalVariables.shared.meetingAllCount = responseObject["result_count"].int!

          if let responseDict = responseObject["staff_report"].arrayObject
          {
                let reportBirthdayModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [ReportStaffListModel]()
                for item in reportBirthdayModel {
                    let single = ReportStaffListModel.build(item)
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
    
    func callAPIReportVideoList(url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,dynamic_db:String,office:String, onSuccess successCallback: ((_ reportBirthdayModel: [ReportVideoListModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        
        let parameters: Parameters = ["dynamic_db":dynamic_db,"paguthi": "","offset": offset,"rowcount": rowcount,"office":""]
        // call API
        self.createRequestReportBirthday(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
         GlobalVariables.shared.meetingAllCount = responseObject["result_count"].int!

          if let responseDict = responseObject["video_report"].arrayObject
          {
                let reportBirthdayModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [ReportVideoListModel]()
                for item in reportBirthdayModel {
                    let single = ReportVideoListModel.build(item)
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
    
    func callAPIReportConstituentList(url: String, whatsap: String, emailId: String, voterId: String, paguthi: String,offset:String,rowCount:String,dob: String, phoneNum: String, keyword: String,dynamic_db:String,office:String , onSuccess successCallback: ((_ reportBirthdayModel: [ReportConstituentListModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        
        let parameters: Parameters = ["dynamic_db":dynamic_db,"whatsapp_no": whatsap,"paguthi": "","offset": offset,"rowcount":rowCount,"mobile_no":phoneNum,"office":"","voter_id_no":voterId,"dob":dob,"email_id":emailId]
        // call API
        self.createRequestReportBirthday(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
         GlobalVariables.shared.meetingAllCount = responseObject["result_count"].int!

          if let responseDict = responseObject["constituent_report"].arrayObject
          {
                let reportBirthdayModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [ReportConstituentListModel]()
                for item in reportBirthdayModel {
                    let single = ReportConstituentListModel.build(item)
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
    func callAPIReportFestivalList(url : String,From: String,from_date: String,to_date: String,status: String,paguthi: String,offset: String,rowcount: String,category: String,sub_category: String,keyword: String,dynamic_db:String,office:String, onSuccess successCallback: ((_ reportBirthdayModel: [ReportFestivalListModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + url
        let parameters: Parameters
        // Set Parameters

        if keyword == "no"{
              parameters = ["dynamic_db":dynamic_db,"from_year": from_date,"to_year": to_date,"paguthi": "","offset": offset,"rowcount": rowcount,"keyword":keyword,"office":"","festival":status]
        }
        else{
             parameters =  ["dynamic_db":dynamic_db,"from_year": from_date,"to_year": to_date,"paguthi": "","offset": offset,"rowcount": rowcount,"keyword":keyword,"office":"","festival":status]
        }
        // call API
        self.createRequestReportBirthday(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
         GlobalVariables.shared.meetingAllCount = responseObject["result_count"].int!

          if let responseDict = responseObject["birthday_report"].arrayObject
          {
                let reportBirthdayModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [ReportFestivalListModel]()
                for item in reportBirthdayModel {
                    let single = ReportFestivalListModel.build(item)
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
    
    
    // MARK: MAKE REPORT BIRTHDAY ALL URL REQUEST
    func createRequestReportBirthday(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
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
    
    //MARK: GET USER PROFILE DETAILS RESPONSE
    func callAPIUserProfileDetails(dynamic_db:String,user_id:String, onSuccess successCallback: ((_ userProfileModel: UserProfileModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.profileDetailsUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"user_id": user_id]
        // call API
        self.createUserProfileDetails(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

          let respphone_number = responseObject["userData"]["phone_number"].string
          let respuser_role = responseObject["userData"]["user_role"].string
          let resPro_pic = responseObject["userData"]["picture_url"].string
          let resppugathi_id = responseObject["userData"]["pugathi_id"].string
          let respconstituency_id = responseObject["userData"]["constituency_id"].string
          let respemail_id = responseObject["userData"]["email_id"].string
          let respfull_name = responseObject["userData"]["full_name"].string
          let respaddress = responseObject["userData"]["address"].string
          let respgender = responseObject["userData"]["gender"].string
          let respuser_id = responseObject["userData"]["user_id"].string

            
          // Create object
          let sendToModel = UserProfileModel()
          sendToModel.phone_number = respphone_number
          sendToModel.user_role = respuser_role
          sendToModel.picture_url = resPro_pic
          sendToModel.pugathi_id = resppugathi_id
          sendToModel.constituency_id = respconstituency_id
          sendToModel.email_id = respemail_id
          sendToModel.full_name = respfull_name
          sendToModel.address = respaddress
          sendToModel.gender = respgender
          sendToModel.user_id = respuser_id
          successCallback?(sendToModel)
          
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE USER PROFILE DETAILS REQUEST
    func createUserProfileDetails(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
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
    
    //MARK: GET USER PROFILE UPDATE RESPONSE
    func callAPIUserProfileUpdate(dynamic_db:String,user_id:String,name:String,address:String,phone:String,email:String,gender:String, onSuccess successCallback: ((_ userProfileUpdateModel: UserProfileUpdateModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.profileUpdateUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"user_id": user_id,"name": name,"address": address,"phone": phone,"email": email,"gender": gender]
        // call API
        self.createUserProfileUpdate(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

         let respMsg = responseObject["msg"].string
         let respStatus = responseObject["status"].string


         // Create object
         let sendToModel = UserProfileUpdateModel()
         sendToModel.msg = respMsg
         sendToModel.status = respStatus
        
        successCallback?(sendToModel)
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE USER PROFILE  UPDATE REQUEST
    func createUserProfileUpdate(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
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
    
    // NOt USED
    //MARK: GET USER PROFILE PIC UPDATE RESPONSE
    func callAPIUserProfilePicUpdate(dynamic_db:String,user_id:String, onSuccess successCallback: ((_ userProfilePicModel: UserProfilePicModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.profilePicUrl.rawValue + user_id
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"user_pic": ""]
        // call API
        self.createUserProfilePicUpdate(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)

          guard let status = responseObject["status"].string, status == "Success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }

    // MARK: MAKE USER PROFILE PIC UPDATE REQUEST
    func createUserProfilePicUpdate(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
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
    
    //MARK: GET CHANGE PASSWORD RESPONSE
    func callAPIChangePassword(dynamic_db:String,user_id:String,new_password:String,old_password:String, onSuccess successCallback: ((_ changePasswordModel: ChangePasswordModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.changePasswordUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["dynamic_db":dynamic_db,"user_id": user_id,"new_password": new_password,"old_password": old_password]
        // call API
        self.createChangePassword(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let status = responseObject["status"].string, status == "success" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

          let respMsg = responseObject["msg"].string
          let respStatus = responseObject["status"].string

          // Create object
          let sendToModel = ChangePasswordModel()
          sendToModel.msg = respMsg
          sendToModel.status = respStatus
          successCallback?(sendToModel)
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
     )
    }
    
    // MARK: MAKE CHANGE PASSWORD REQUEST
    func createChangePassword(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
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
