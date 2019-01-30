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
    @IBAction func prepareForUnWind(segue : UIStoryboardSegue){}
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController()!.rearViewRevealWidth = self.view.frame.size.width - 60
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
   

}
