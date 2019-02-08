//
//  addChannelVC.swift
//  Smack
//
//  Created by zeyad on 2/8/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

class addChannelVC: UIViewController {
    //outlets
    
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descripTxt: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        bgView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(){
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createChannelBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
