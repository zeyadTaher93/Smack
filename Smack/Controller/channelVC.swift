//
//  channelVC.swift
//  Smack
//
//  Created by Zeyad Taher on 1/27/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

class channelVC: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    

    @IBOutlet weak var channelTableView: UITableView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBAction func prepareForUnWind(segue : UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channelTableView.delegate = self
        channelTableView.dataSource = self
        self.revealViewController()!.rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(userDataChanged(_:)), name: NOTI_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(channelsLoaded(_:)), name: NOTI_CHANNELS_LOADED, object: nil)
        SocketService.instance.getChannel { (success) in
            if success {
                self.channelTableView.reloadData()
            }else{
            }
        }
        
    }
   
    @objc func channelsLoaded(_ notif: Notification){
        channelTableView.reloadData()
    }
    
    @objc func userDataChanged(_ notif: Notification){
        channelTableView.reloadData()
        setUserInfo()
    }
    
    @IBAction func addChannelBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let addChannel = addChannelVC()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profile = profileViewVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        channelTableView.reloadData()
        setUserInfo()
    }
    func setUserInfo(){
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.bg
            channelTableView.reloadData()
            
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userImage.image  = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
            channelTableView.reloadData()
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? channelCell {
             let channel = MessageService.instance.channels[indexPath.row]
             cell.configureCell(channel: channel)
            return cell
        }else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTI_CHANNELS_SELECTED, object: nil)
        self.revealViewController()?.revealToggle(animated: true)
    }
}
