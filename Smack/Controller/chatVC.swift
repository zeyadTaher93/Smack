//
//  chatVC.swift
//  Smack
//
//  Created by Zeyad Taher on 1/27/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

class chatVC: UIViewController ,UITableViewDelegate , UITableViewDataSource {
  
    

    //Outlets
    
    @IBOutlet weak var sideMenuBtn: UIButton!
    @IBOutlet weak var smackLbl: UILabel!
    @IBOutlet weak var messageTxt: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    
    var isTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        sendBtn.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        sideMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(chatVC.userDataChanged(_:)), name: NOTI_USER_DATA_DID_CHANGE, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected(_:)), name: NOTI_CHANNELS_SELECTED, object: nil)
        
        SocketService.instance.getMessages { (success) in
            if success {
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndexPath = IndexPath(row: MessageService.instance.messages.count-1, section: 0)
                    self.tableView.scrollToRow(at: endIndexPath, at:.bottom , animated: false)
                }
            }
        }
        
        
        if AuthService.instance.isLoggedIn && AuthService.instance.authToken != "" {
            AuthService.instance.findUserByEmail { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTI_USER_DATA_DID_CHANGE, object: nil)
                    
                }
            }
        }
    }
    
    @objc func handleTap(){
        view.endEditing(true)
    }
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        if messageTxt.text == "" {
        isTyping = false
        sendBtn.isHidden = true
        }else{
           
            sendBtn.isHidden = false
            isTyping = true
            
        }
    }
    
    @IBAction func sendMessageBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?.channelID else{return}
            guard let messageBody = messageTxt.text else {return}
            
            sendBtn.isHidden = true
            
            SocketService.instance.addMessage(messageBody: messageBody, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                self.messageTxt.text = ""
                self.messageTxt.resignFirstResponder()
                
            }
        }
    }
    
    
    
    
    
    
    @objc func channelSelected(_ notif: Notification){
      updateWithChannel()
    }
    func updateWithChannel(){
        smackLbl.text = MessageService.instance.selectedChannel?.channelTitle
        getMessages()
    }
    @objc func userDataChanged(_ notif: Notification){
        if AuthService.instance.isLoggedIn{
            onLoginGetMessages()
        }else{
            smackLbl.text = "please log in!"
            tableView.reloadData()
        }
    }
    
    func onLoginGetMessages(){
        MessageService.instance.findAllChannel { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                }else{
                    self.smackLbl.text = "No channels yet !"
                }
                
            }
            
        }
    }
    
    func getMessages(){
        guard let channelId = MessageService.instance.selectedChannel?.channelID else{return}
        MessageService.instance.findAllMessagesForChannel(channelID: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? messageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }else{
            return UITableViewCell()
        }
        
    
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   MessageService.instance.messages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
}

