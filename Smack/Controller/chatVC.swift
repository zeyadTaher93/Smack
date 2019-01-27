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
        
        
    }
    


}
