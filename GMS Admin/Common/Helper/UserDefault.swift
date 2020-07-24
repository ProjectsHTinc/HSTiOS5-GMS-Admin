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
      case ConsProfilekey
      case splashkey
      case profileInfokey
      case constituentIDkey
      case userLocationkey
      case userImagekey

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
    
    open func setConsProfileInfo<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        
        set(data, forKey: UserDefaultsKey.ConsProfilekey.rawValue)
    }
    
    open func getConsProfileInfo<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: UserDefaultsKey.ConsProfilekey.rawValue) as? [Data] else {
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
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.ConsProfilekey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.constituentIDkey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.userLocationkey.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.userImagekey.rawValue)

    }
}
