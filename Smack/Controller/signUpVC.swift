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
    
    //Default Values
    var avatarName = "profileDefault"
    var avatarColor = "[0.5 , 0.5 , 0.5, 1]"
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func createAccountBtnPressed(_ sender: Any) {
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
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    
    @IBAction func generateBGPressed(_ sender: Any) {
    }
    
}
