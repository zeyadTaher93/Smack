//
//  UserDataService.swift
//  Smack
//
//  Created by Zeyad Taher on 1/31/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import Foundation
class UserDataService {
   static let instance = UserDataService()
    
   public private(set) var id = ""
   public private(set) var avatarColor = ""
   public private(set) var avatarName = ""
   public private(set) var name = ""
   public private(set) var email = ""
//   public private(set) var bg = UIColor.lightGray
    
    func setUserData(id: String , avatarColor: String , avatarName: String , name: String , email: String){
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.name = name
        self.email = email
        
        }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
    
    
//    func setBGcolor(bg: UIColor){
//        self.bg = bg
//    }
    
    func returnUIColor(components: String) -> UIColor{
        //"[0.9921568627450981, 0.07450980392156863, 0.8392156862745098, 1]"
        
        
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ]")
        let comma = CharacterSet(charactersIn: ",")
        
        scanner.charactersToBeSkipped = skipped
        
        var r , g ,b , a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnWrapped = r else{return defaultColor}
        guard let gUnWrapped = g else{return defaultColor}
        guard let bUnWrapped = b else{return defaultColor}
        guard let aUnWrapped = a else{return defaultColor}
        
        let rFloat = CGFloat(rUnWrapped.doubleValue)
        let gFloat = CGFloat(gUnWrapped.doubleValue)
        let bFloat = CGFloat(bUnWrapped.doubleValue)
        let aFloat = CGFloat(aUnWrapped.doubleValue)
        
        let newUIColor = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        
        
        return newUIColor
    }
}
