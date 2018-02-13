//
//  NetworkCallback.swift
//  KUSBF
//
//  Created by 김지우 on 2017. 12. 25..
//  Copyright © 2017년 jiwoo. All rights reserved.
//

protocol NetworkCallback {
    
    func networkResult(resultData:Any, code:String)
    func networkFailed()
    
}


