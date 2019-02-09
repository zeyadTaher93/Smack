//
//  chatVC.swift
//  Smack
//
//  Created by Zeyad Taher on 1/27/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

class chatVC: UIViewController {

    //Outlets
    
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var smackLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(chatVC.userDataChanged(_:)), name: NOTI_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: NOTI_CHANNELS_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTI_USER_DATA_DID_CHANGE, object: nil)
                    
                }
            }
        }
    }
    @objc func channelSelected(_ notif: Notification){
      updateWithChannel()
    }
    func updateWithChannel(){
        smackLbl.text = MessageService.instance.selectedChannel?.channelTitle
    }
    @objc func userDataChanged(_ notif: Notification){
        if AuthService.instance.isLoggedIn{
            onLoginGetMessages()
        }else{
            smackLbl.text = "please log in!"
        }
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannel { (success) in
            if success {
                
            }
            
        }
    }
}

