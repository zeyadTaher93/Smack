//
//  profileViewVC.swift
//  Smack
//
//  Created by Zeyad Taher on 2/3/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

class profileViewVC: UIViewController {

    //outlets
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var profileImg: cornerImage!
    @IBOutlet weak var bgView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
 
    
    func setupView(){
        nameLbl.text = UserDataService.instance.name
        emailLbl.text = UserDataService.instance.email
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandling))
        view.addGestureRecognizer(tap)
    }
 
    @objc func tapHandling(){
        dismiss(animated: true, completion: nil)
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
        AuthService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTI_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
}
