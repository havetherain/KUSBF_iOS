//
//  CustomPickerView.swift
//  KUSBF
//
//  Created by 김지우 on 2017. 12. 25..
//  Copyright © 2017년 jiwoo. All rights reserved.
//

import UIKit

class CustomPickerView: UITextField {
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    } // No Cursor Textfield
}
