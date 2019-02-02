//
//  cornerImage.swift
//  Smack
//
//  Created by Zeyad Taher on 2/2/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

class cornerImage: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView(){
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
