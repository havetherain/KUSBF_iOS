//
//  CircleImageView.swift
//  KUSBF
//
//  Created by 김지우 on 2017. 12. 28..
//  Copyright © 2017년 jiwoo. All rights reserved.
//

import Foundation
import UIKit

class CircleImageView : UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.frame = CGRect(x: 72, y: 72, width: 72, height: 72)
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width/2.0
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor
        
    }
}
