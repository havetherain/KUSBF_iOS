//
//  UnionInfoVC.swift
//  KUSBF
//
//  Created by 김지우 on 2017. 12. 26..
//  Copyright © 2017년 jiwoo. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import SwiftyJSON
class UnionInfoVC : UIViewController {
    let userDefault = UserDefaults.standard
    var univRankList : [[String]] = [[], []]
    
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var schoolRankTableView: UITableView!
    @IBOutlet weak var name1Label: UILabel!
    @IBOutlet weak var name2Label: UILabel!
    @IBOutlet weak var name3Label: UILabel!
    @IBOutlet weak var name4Label: UILabel!
    @IBOutlet weak var name5Label: UILabel!
    @IBOutlet weak var name6Label: UILabel!
    @IBOutlet weak var name7Label: UILabel!
    @IBOutlet weak var name8Label: UILabel!
    @IBOutlet weak var name9Label: UILabel!
    @IBOutlet weak var name10Label: UILabel!
    @IBOutlet weak var school1Label: UILabel!
    @IBOutlet weak var school2Label: UILabel!
    @IBOutlet weak var school3Label: UILabel!
    @IBOutlet weak var school4Label: UILabel!
    @IBOutlet weak var school5Label: UILabel!
    @IBOutlet weak var school6Label: UILabel!
    @IBOutlet weak var school7Label: UILabel!
    @IBOutlet weak var school8Label: UILabel!
    @IBOutlet weak var school9Label: UILabel!
    @IBOutlet weak var school10Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolRankTableView.delegate = self
        schoolRankTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let kusbfInfo = userDefault.object(forKey: "KusbfInfo") as? Data else{
            return
        }
        totalScoreLabel.text = JSON(kusbfInfo)["total_score"].stringValue
        top10Set(try! JSON(JSON(kusbfInfo)["top10"].rawData()))
        univRankSet(try! JSON(JSON(kusbfInfo)["univ_rank"].rawData()))
    }
    
    func top10Set(_ top10: JSON) {
        name1Label.text = top10["names"][0].stringValue
        name2Label.text = top10["names"][1].stringValue
        name3Label.text = top10["names"][2].stringValue
        name4Label.text = top10["names"][3].stringValue
        name5Label.text = top10["names"][4].stringValue
        name6Label.text = top10["names"][5].stringValue
        name7Label.text = top10["names"][6].stringValue
        name8Label.text = top10["names"][7].stringValue
        name9Label.text = top10["names"][8].stringValue
        name10Label.text = top10["names"][9].stringValue
     
        school1Label.text = top10["froms"][0].stringValue
        school2Label.text = top10["froms"][1].stringValue
        school3Label.text = top10["froms"][2].stringValue
        school4Label.text = top10["froms"][3].stringValue
        school5Label.text = top10["froms"][4].stringValue
        school6Label.text = top10["froms"][5].stringValue
        school7Label.text = top10["froms"][6].stringValue
        school8Label.text = top10["froms"][7].stringValue
        school9Label.text = top10["froms"][8].stringValue
        school10Label.text = top10["froms"][9].stringValue
    }
    
    func univRankSet(_ univInfo: JSON) {
        for num in 0...univInfo["names"].count - 1 {
            univRankList[0].append(univInfo["names"][num].stringValue)
            univRankList[1].append(univInfo["scores"][num].stringValue)
        }
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

extension UnionInfoVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return univRankList[0].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolRankCell", for: indexPath) as! SchoolRankCell
        cell.rankLabel.text = "\(indexPath.row+1)"
        cell.schoolLabel.text = univRankList[0][indexPath.row]
        cell.scoreLabel.text = univRankList[1][indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}

