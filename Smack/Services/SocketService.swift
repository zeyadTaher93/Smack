//
//  SocketService.swift
//  Smack
//
//  Created by zeyad on 2/8/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    
    
    override init() {
        super.init()
      
    }
    
    let socket = SocketManager(socketURL: URL(string:BASE_URL)!, config: [.log(true), .compress])

    
    func establishConnection(){
        socket.defaultSocket.connect()
        print("sockets connected")
    }
    func closeConnection(){
        socket.defaultSocket.disconnect()
        print("sockets disconnected")
    }
    
    func addChannel(channelName:String , channelDescription: String , completion: @escaping(ComplitionHandler)){
        
        socket.defaultSocket.emit("newChannel", channelName ,channelDescription )
        completion(true)
        
    }
    
    
    func getChannel(comletion: @escaping(ComplitionHandler)){
        socket.defaultSocket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else{return}
            guard let channelDescription = dataArray[1] as? String else{return}
            guard let channelID = dataArray[2] as? String else{return}
            
            let newChannel = Channel(channelTitle: channelName , channelID: channelID , channelDescription: channelDescription)
            
            MessageService.instance.channels.append(newChannel)
            comletion(true)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
