//
//  messageCell.swift
//  Smack
//
//  Created by zeyad on 2/10/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

class messageCell: UITableViewCell {

    @IBOutlet weak var userImg: cornerImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var messageLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message){
        messageLbl.text = message.message
        userNameLbl.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
    }

}
