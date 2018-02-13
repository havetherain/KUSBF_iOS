//
//  LoginVC.swift
//  KUSBF
//
//  Created by 김지우 on 2017. 12. 23..
//  Modified & Approved by 양기창
//  Copyright © 2017년 jiwoo. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class User : Object {
    @objc dynamic var id = ""
    @objc dynamic var pwd = ""
}
class LoginVC : UIViewController, UITextFieldDelegate {
    let userDefault = UserDefaults.standard
    
    @IBOutlet weak var idTxt: UITextField!
    @IBOutlet weak var pwTxt: UITextField!
    let tmp = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pwTxt.delegate = self;
        self.idTxt.delegate = self;
    }
   
    @IBAction func loginBtn(_ sender: Any) {
        guard let id = idTxt.text, let pwd = pwTxt.text else {
            return
        }
        if(id == tmp.id && pwd == tmp.pwd) {return}
        tmp.id = id
        tmp.pwd = pwd
        if id.isEmpty {
            simpleAlert(title: "Login", message: "ID를 입력해주세요")
        } else if pwd.isEmpty {
            simpleAlert(title: "Login", message: "PW를 입력해주세요")
        } else {
            guard let splashVC = self.storyboard?.instantiateViewController(withIdentifier: "SplashVC") else {
                return
            }
            SignService.loginService(id: id, pwd: pwd, onLogin: { (res) in
                print(res)
                if res == 0 {
                    self.simpleAlert(title: "로그인 실패", message: "올바른 정보를 입력하십시오.")
                    self.tmp.id = ""
                    self.tmp.pwd = ""
                    return
                    
                } else if res == -1 {
                    self.simpleAlert(title: "네트워크 오류", message: "네트워크 연결상태를 확인하십시오.")
                    self.tmp.id = ""
                    self.tmp.pwd = ""
                }
                
                let user = User()
                user.id = id
                user.pwd = pwd
                
                let realm = try! Realm()
                try! realm.write {
                    realm.add(user)
                }
            
                self.present(splashVC, animated: true)
            }
            )
        }
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        guard let registerNC = storyboard?.instantiateViewController(withIdentifier: "RegisterNC") as? UINavigationController else {
            return
        }
        present(registerNC, animated: true)
    }


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        idTxt.text = ""
        pwTxt.text = ""
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true) // textBox는 textFiled 오브젝트 outlet 연동할때의 이름.
        
    }
    
    
    
}
