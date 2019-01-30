//
//  roundedCorner.swift
//  Smack
//
//  Created by Zeyad Taher on 1/30/19.
//  Copyright © 2019 Zeyad Taher. All rights reserved.
//

import UIKit

@IBDesignable
class roundedCorner: UIButton {

    @IBInspectable var cornerRadius : CGFloat = 3.5 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    override func awakeFromNib() {
        setUpView()
    }
    
    func setUpView() {
        self.layer.cornerRadius = cornerRadius
    }

}
