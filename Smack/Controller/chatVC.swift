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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        sideMenuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTI_USER_DATA_DID_CHANGE, object: nil)
                }
            }
        }
        MessageService.instance.findAllChannel { (success) in
            if success {
                print("hello")
            }
        }
    }
    


}
