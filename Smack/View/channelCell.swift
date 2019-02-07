//
//  channelCell.swift
//  Smack
//
//  Created by zeyad on 2/7/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

class channelCell: UITableViewCell {

    //outlets
    @IBOutlet weak var channelNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel: Channel){
        let title = channel.channelTitle ?? ""
        channelNameLbl.text = "#\(title)"
        
    }

}
