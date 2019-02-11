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
   public private(set) var bg = UIColor.lightGray
    
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
    
    
    func setBGcolor(bg: UIColor){
        self.bg = bg
    }
}
