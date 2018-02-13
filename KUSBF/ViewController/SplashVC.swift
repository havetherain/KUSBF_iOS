//
//  SplashVC.swift
//  KUSBF
//
//  Created by 김지우 on 2018. 1. 8..
//  Modified & Approved by 양기창
//  Copyright © 2018년 jiwoo. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift
import SwiftyJSON

class SplashVC : UIViewController {
    let userDefault = UserDefaults.standard
    
    func check() -> Bool {
        
        let realm = try! Realm()
        var userList : Results<User>?
        userList = realm.objects(User.self)
        if userList?.count == 0 {return false}
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let realm = try! Realm()
        var userList : Results<User>?
        userList = realm.objects(User.self)
        if  userList?.count == 0 {
            print("not registered")
            guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {
                return
            }
            self.present(loginVC, animated: true)
        } else {
            guard let id = userList?.first?.id, let pwd = userList?.first?.pwd else {
                return
            }
            
            self.simpleAlert(title: "정보를 가져오는중", message: "등록후 최초 로그인시 10-20초정도의 시간이 소요됩니다.")
            SignService.getInfoService(id: id, pwd: pwd, onLogin: { (res, judge) in
                guard let mainTabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarVC") as? UITabBarController else {
                    return
                }
        
                if (res == JSON.null) {
                    self.simpleAlert(title: "네트워크 에러", message: "정보를 가져오지 못했습니다. 다시 시도하십시오.")
                }
                else {
                    let jres = JSON(try! res.rawData())
                    if(jres["main_info"]==JSON.null) { return }
                
                    self.userDefault.set(try! jres["main_info"].rawData(), forKey: "MainInfo")
                    self.userDefault.set(try! jres["kusbf"].rawData(), forKey: "KusbfInfo")
                    print("삽입 완료")
                    self.present(mainTabBarVC, animated: true)
                }
            })
        }
    }

}
