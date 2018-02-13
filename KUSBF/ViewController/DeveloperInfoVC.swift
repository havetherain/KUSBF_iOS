//
//  DeveloperInfoVC.swift
//  KUSBF
//
//  Created by 김지우 on 2017. 12. 26..
//  Copyright © 2017년 jiwoo. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class DeveloperInfoVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func logoutBtn(_ sender: Any) {
        let realm = try! Realm()
        realm.beginWrite()
        var userList : Results<User>?
        userList = realm.objects(User.self)
        if userList?.count != 0 {
            realm.delete((userList?[0])!)
            try! realm.commitWrite()
        }
        
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else {
            return
        }
        present(loginVC, animated: true)
    }
}

