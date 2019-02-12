//
//  AuthService.swift
//  Smack
//
//  Created by Zeyad Taher on 1/30/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken : String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
        
    }
    
    var UserEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    
    
    
    func registerUser(email: String , password: String  , completion: @escaping ComplitionHandler ){
        
        let lowerCasedEmail = email.lowercased()
        
        let header = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String : Any] = [
            "email": lowerCasedEmail ,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default , headers: header).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func logInUser(email: String , password: String , completion: @escaping ComplitionHandler){
        let lowerCasedEmail = email.lowercased()
        
        let header = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String : Any] = [
            "email": lowerCasedEmail ,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                if let json = response.result.value as? Dictionary<String , Any> {
                 
                    if let email = json["user"] as? String {
                        self.UserEmail = email
                    }
                    if let token = json["token"] as? String {
                        self.authToken = token
                    }
                 
                }
                 self.isLoggedIn = true
                 completion(true)
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createUser(name: String , email: String , password: String ,avatarColor: String , avatarName: String , completion: @escaping ComplitionHandler ){
        
        let lowerCasedEmail = email.lowercased()
        
        let header = [
            "Authorization": "Bearer \(AuthService.instance.authToken)" ,
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String : Any] = [
            "name": name,
            "email": lowerCasedEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                
                guard let data = response.data  else {return}
                
                let json = try!  JSON(data: data)
            
                let id = json["_id"].stringValue
                let avatarColor = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue
                UserDataService.instance.setUserData(id: id, avatarColor: avatarColor, avatarName: avatarName, name: name, email: email)
                completion(true)
    
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        
        
    }
    
    func logoutUser(){
        self.isLoggedIn = false
        self.authToken = ""
        self.UserEmail = ""
        UserDataService.instance.setUserData(id: "", avatarColor: "", avatarName: "", name: "", email: "")
        
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
    
    
    func findUserByEmail(completion: @escaping ComplitionHandler){
        
        let header = [
            "Authorization": "Bearer \(AuthService.instance.authToken)" ,
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        Alamofire.request("\(URL_FIND_USER_BY_EMAIL)\(UserEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                
                guard let data = response.data  else {return}
                self.setUpUserInfo(data: data)
                
                completion(true)
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
    }
    func setUpUserInfo(data: Data){
        let json = try!  JSON(data: data)
        
        let id = json["_id"].stringValue
        let avatarColor = json["avatarColor"].stringValue
        let avatarName = json["avatarName"].stringValue
        let email = json["email"].stringValue
        let name = json["name"].stringValue
        UserDataService.instance.setUserData(id: id, avatarColor: avatarColor, avatarName: avatarName, name: name, email: email)
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
