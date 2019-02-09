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
    
}
