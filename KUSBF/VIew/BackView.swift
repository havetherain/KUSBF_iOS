//
//  BackCardView.swift
//  KUSBF
//
//  Created by 김지우 on 2017. 12. 28..
//  Copyright © 2017년 jiwoo. All rights reserved.
//

import Foundation
import UIKit

class BackView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4).cgColor
        
        self.layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let shadowPath = UIBezierPath(rect : self.bounds)
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.12
        self.layer.shadowPath = shadowPath.cgPath
    }
}
