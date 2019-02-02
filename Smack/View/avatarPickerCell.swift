//
//  avatarPickerCell.swift
//  Smack
//
//  Created by Zeyad Taher on 2/2/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

enum avatarType{
    case dark
    case light
}

class avatarPickerCell: UICollectionViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configureCell(index: Int ,type: avatarType ){
        if type == avatarType.dark {
            avatarImage.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }else{
            avatarImage.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    
    
    func setupView(){
        self.layer.backgroundColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
}
