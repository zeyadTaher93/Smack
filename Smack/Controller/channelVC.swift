//
//  channelVC.swift
//  Smack
//
//  Created by Zeyad Taher on 1/27/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

class channelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBAction func prepareForUnWind(segue : UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()!.rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(userDataChanged(_:)), name: NOTI_USER_DATA_DID_CHANGE, object: nil)
    }
   
    
    @objc func userDataChanged(_ notif: Notification){
        setUserInfo()
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
        setUserInfo()
    }
    func setUserInfo(){
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImage.image = UIImage(named: UserDataService.instance.avatarName)
            userImage.backgroundColor = UserDataService.instance.bg
        }else{
            loginBtn.setTitle("Login", for: .normal)
            userImage.image  = UIImage(named: "menuProfileIcon")
            userImage.backgroundColor = UIColor.clear
        }
    }
   

}
