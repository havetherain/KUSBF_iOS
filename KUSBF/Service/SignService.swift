//
//  SignService.swift
//  KUSBF
//
//  Created by 김지우 on 2017. 12. 25..
//  Copyright © 2017년 jiwoo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct SignService {
    static let baseURL = "http://127.0.0.1:9000"
    static func judgeService(id : String, pwd : String, onJudge : @escaping (String) -> ()) {
        let URL = "\(baseURL)/boing/check/"
        let params = ["id" : id, "passwd" : pwd]
        Alamofire.request(URL, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (res) in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    onJudge(data["result"].stringValue)
                }
                break
            case .failure(let err) :
                onJudge("-1")
                print(err.localizedDescription)
                break
            }
        }
    }
    static func registerService(id : String, pwd : String, univ : String, onRegi : @escaping (String) -> ()) {
        let URL = "\(baseURL)/boing/regist/"
        let params = ["id" : id, "passwd" : pwd, "univ" : univ]
        Alamofire.request(URL, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { (res) in
            switch res.result {
            case .success :
                if let value = res.result.value {
                    let data = JSON(value)
                    guard let msg = data["result"].string else {
                        return
                    }
                    //TODO : show success feedback and goto loginView
                    onRegi(msg)
                }
                break
            case .failure(let err) :
                onRegi("error")
                print(err.localizedDescription)
                break
            }
        }
    }
    static func loginService(id : String, pwd : String, onLogin : @escaping(Int) -> ()) {
        let URL = "\(baseURL)/boing/login/"
        print(URL)
        let params = ["id" : id, "passwd" : pwd]
        print(params)
        Alamofire.request(URL, method: .post, parameters: params, encoding: URLEncoding.default).responseData { (res) in
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let data = JSON(value)
                    onLogin(data["result"].intValue)
                }
                break
            case .failure(let err) :
                onLogin(-1)
                print(err.localizedDescription)
                
                break
            }
        }
    }
    
    static func getInfoService(id : String, pwd : String, onLogin : @escaping(JSON, String) -> ()) {
        let URL = "\(baseURL)/boing/maininfo/"
        let params = ["id" : id, "passwd" : pwd]
    
        Alamofire.SessionManager.default.session.configuration.timeoutIntervalForRequest = 3000
        Alamofire.request(URL, method: .post, parameters: params, encoding: URLEncoding.default).responseData { (res) in
            print("result")
            switch res.result {
            case .success:
                if let value = res.result.value {
                    let dat = JSON(value)
                    print(dat)
                    onLogin(dat, "true")
                }
                
                break
            case .failure(let err) :
                onLogin(JSON.null,"false")
                print(err.localizedDescription)
                print("onError")
                break
            }
        }
    }
}
