//
//  loginVC.swift
//  Smack
//
//  Created by Zeyad Taher on 1/28/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

class loginVC: UIViewController {
    //outlets
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_SIGNUP, sender: nil)
        
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
         spinner.isHidden = false
         spinner.startAnimating()
         guard let name = userNameTxt.text , userNameTxt.text != "" else {return}
        
         guard let password = passwordTxtField.text , passwordTxtField.text != "" else {return}
        
        AuthService.instance.logInUser(email: name, password: password) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                         NotificationCenter.default.post(name: NOTI_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    func setUpView(){
        spinner.isHidden = true
    }

}
