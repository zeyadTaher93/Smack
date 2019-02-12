//
//  signUpVC.swift
//  Smack
//
//  Created by Zeyad Taher on 1/28/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

class signUpVC: UIViewController {
    
    //outlets
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //vars
    var bgColor: UIColor?
    
    
    
    //Default Values
    var avatarName = "profileDefault"
    var avatarColor = "[0.5 , 0.5 , 0.5, 1]"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        guard let name = userNameTxt.text , userNameTxt.text != "" else {return}
        guard let email = emailTxt.text , emailTxt.text != "" else {return}
        guard let password = passwordTxt.text , passwordTxt.text != "" else {return}
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthService.instance.logInUser(email: email, password: password, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, password: password, avatarColor: self.avatarColor, avatarName: self.avatarName, completion: { (success) in
                            if success {
                                self.performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
                                print("User Added successfully!!" ,UserDataService.instance.name , UserDataService.instance.id)
                                NotificationCenter.default.post(name: NOTI_USER_DATA_DID_CHANGE, object: nil
                                )
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                            }
                        })
                    }
                })
            }
        }
    }
    
    func setupView() {
        spinner.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
       view.endEditing(true)
    }
    
    
    
    
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func generateBGPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
//        avatarColor = "[\(r) , \(g) , \(b) , 1]"
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r), \(g), \(b), 1]"
        
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor
        }
        
        
    }
    
}
