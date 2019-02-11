//
//  Channels.swift
//  Smack
//
//  Created by zeyad on 2/7/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel: Channel?
    var messages = [Message]()
    
    let header = [
        "Authorization": "Bearer \(AuthService.instance.authToken)" ,
//        "Content-Type": "application/json; charset=utf-8"
    ]
    func findAllChannel(completion: @escaping ComplitionHandler){
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                guard let date = response.data else {return}
                if let json = try! JSON(data: date).array{
                    
                    for item in json {
                        let name = item["name"].stringValue
                        let description = item["descriptiom"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle:name , channelID: id, channelDescription:description)
                        self.channels.append(channel)
                        
                    }
                    NotificationCenter.default.post(name: NOTI_CHANNELS_LOADED, object: nil)
                    completion(true)
                }
                
                
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearChannels(){
        channels.removeAll()
    }
    func clearMessages(){
        messages.removeAll()
    }
    
    func findAllMessagesForChannel(channelID: String , completion: @escaping(ComplitionHandler)){
        let url = "\(URL_GET_MESSAGES)/\(channelID)"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                self.clearMessages()
                guard let data = response.data else {return}
                if let json = try! JSON(data: data).array{
                    
                    for item in json {
                        let messagebody = item["messageBody"].stringValue
                        let userName = item["userName"].stringValue
                        let channelID = item["channelId"].stringValue
                        let userAvatar = item["userAvatar"].stringValue
                        let userAvatarColor = item["userAvatarColor"].stringValue
                        let id = item["_id"].stringValue
                        let timeStamp = item["timeStamp"].stringValue
                        
                        let message = Message(message: messagebody, userName: userName, channelId: channelID, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
        
                        self.messages.append(message)
                        
                    }
                    completion(true)
                }
                
                
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
        
    }
    
}
