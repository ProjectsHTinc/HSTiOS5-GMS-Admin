//
//  UserDefault.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

enum UserDefaultsKey : String
{
      case userOtpListSessionkey
      case userIDkey
      case userNamekey
      case clientAPiUrlkey
      case constituencyNamekey
      case userProfilekey
      case splashkey
      case profileInfokey

}

extension UserDefaults
{
    open func setOtpArray<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        
        set(data, forKey: UserDefaultsKey.userOtpListSessionkey.rawValue)
    }
    
    open func getsOtpArrayData<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: UserDefaultsKey.userOtpListSessionkey.rawValue) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
    
    open func setProfileInfo<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        
        set(data, forKey: UserDefaultsKey.profileInfokey.rawValue)
    }
    
    open func getProfileInfo<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: UserDefaultsKey.profileInfokey.rawValue) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
    
    
    func clearUserData()
    {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.userOtpListSessionkey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.userIDkey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.userNamekey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.clientAPiUrlkey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.constituencyNamekey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.profileInfokey.rawValue)
    }
}
