//
//  PersonInfoVC.swift
//  KUSBF
//
//  Created by 김지우 on 2017. 12. 26..
//  Copyright © 2017년 jiwoo. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import SwiftyJSON
class PersonInfoVC : UIViewController {
    let userDefault = UserDefaults.standard
    
    @IBOutlet weak var userProfile: CircleImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userSchoolLabel: UILabel!
    @IBOutlet weak var userTotalScoreLabel: UILabel!
    @IBOutlet weak var firstRidingLabel: UILabel!
    @IBOutlet weak var lastRidingLabel: UILabel!
    @IBOutlet weak var totalRankLabel: UILabel!
    @IBOutlet weak var genderRankLabel: UILabel!
    @IBOutlet weak var ageRankLabel: UILabel!
    @IBOutlet weak var unionRankLabel: UILabel!
    @IBOutlet weak var outUpCompNameLabel: UILabel!
    @IBOutlet weak var outUpCompSchoolLabel: UILabel!
    @IBOutlet weak var outUpCompScoreLabel: UILabel!
    @IBOutlet weak var outDownCompNameLabel: UILabel!
    @IBOutlet weak var outDownCompSchoolLabel: UILabel!
    @IBOutlet weak var outDownCompScoreLabel: UILabel!
    @IBOutlet weak var schoolRankLabel: UILabel!
    @IBOutlet weak var inUpCompNameLabel: UILabel!
    @IBOutlet weak var inUpCompScoreLabel: UILabel!
    @IBOutlet weak var inDownCompNameLabel: UILabel!
    @IBOutlet weak var inDownCompScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let mainInfoString = userDefault.object(forKey: "MainInfo") as? Data else {
            return
        }
        print(mainInfoString)
        let mainInfo = JSON(mainInfoString)
        
        self.personalInfoSet(mainInfo["info"])
        self.myRankInfoSet(JSON(try! mainInfo["my_rank"].rawData()))
        self.outerInfoSet(JSON(try! mainInfo["out"].rawData()))
        self.innerInfoSet(JSON(try! mainInfo["iin"].rawData()))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func personalInfoSet(_ info :  JSON) {
        self.userProfile.imageFromUrl(info["photo"].stringValue, defaultImgPath: "defaultProfile")
        self.userNameLabel.text = info["my_name"].stringValue
        self.userSchoolLabel.text = info["my_univ"].stringValue
        self.userTotalScoreLabel.text = "\(String(describing: info["my_score"].stringValue))점"
        self.firstRidingLabel.text = info["fboard"].stringValue
        self.lastRidingLabel.text = info["lboard"].stringValue
    }
    
    func myRankInfoSet(_ myRank : JSON) {
        self.totalRankLabel.text = myRank["all"].stringValue
        print(myRank["all"].stringValue)
        self.genderRankLabel.text = myRank["sexual"].stringValue
        self.ageRankLabel.text = myRank["agial"].stringValue
    }
    
    func outerInfoSet(_ outInfo : JSON) {
        self.unionRankLabel.text = "\(outInfo["outrank"].stringValue)"
        self.outUpCompNameLabel.text = outInfo["outun"].stringValue
        self.outUpCompSchoolLabel.text = outInfo["outusn"].stringValue
        self.outUpCompScoreLabel.text = "\(outInfo["outus"].stringValue)"
        self.outDownCompNameLabel.text = outInfo["outdn"].stringValue
        self.outDownCompSchoolLabel.text = outInfo["outdsn"].stringValue
        self.outDownCompScoreLabel.text = "\(outInfo["outds"].stringValue)"
    }
    
    func innerInfoSet(_ inInfo : JSON) {
        self.schoolRankLabel.text = "\(inInfo["inrank"].stringValue)"
        self.inUpCompNameLabel.text = inInfo["inun"].stringValue
        self.inUpCompScoreLabel.text = "\(inInfo["inus"].stringValue)"
        self.inDownCompNameLabel.text = inInfo["indn"].stringValue
        self.inDownCompScoreLabel.text = "\(inInfo["inds"].stringValue)"
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
