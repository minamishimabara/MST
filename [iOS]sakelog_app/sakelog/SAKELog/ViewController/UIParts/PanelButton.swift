//
//  PanelButton.swift
//  SAKELog
//
//  Created by 金子 太祐 on 2016/11/20.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import UIKit

@IBDesignable class PanelButton: UIButton {

    @IBInspectable var radius : CGFloat = 10.0
    @IBInspectable var bWidth : CGFloat = 2.0
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.radius
        self.layer.borderWidth = self.bWidth
        self.clipsToBounds = true
        super.draw(rect)
    }

}
