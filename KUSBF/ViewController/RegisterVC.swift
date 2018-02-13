//
//  RegisterVC.swift
//  KUSBF
//
//  Created by 김지우 on 2017. 12. 25..
//  Copyright © 2017년 jiwoo. All rights reserved.
//

import Foundation
import UIKit

class RegisterVC : UIViewController ,UITextFieldDelegate{
    var backColor : UIColor?
    var judgeColor : UIColor?
    var judge : Bool = false
    var birthList : [[String]] = [[], [], []]
    
    let schoolPickerView = UIPickerView()
    let birthPickerView = UIPickerView()
    let schoolList : [String] = ["건국대학교" , "경기대학교", "경희대학교", "고려대학교", "국민대학교", "단국대학교", "덕성여대학교", "동덕여자대학교", "명지대학교", "서울대학교"
        , "성균관대학교", "성신여자대학교", "세종대학교", "숙명여자대학교", "숭실대학교", "아주대학교", "연세대학교", "용인대학교", "이화여자대학교", "인하대학교", "중앙대학교", "KAIST"
        , "한국외국어대학교", "한국항공대학교", "한양대학교", "홍익대학교"]
    
    @IBOutlet weak var idTxt: UITextField!
    @IBOutlet weak var pwTxt: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var judgeTxt: UILabel!
    @IBOutlet weak var schoolPicker: CustomPickerView!
    @IBOutlet weak var birthPicker: CustomPickerView!
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func judgeBtn(_ sender: Any) {
        guard let id = idTxt.text, let pw = pwTxt.text else {
            return
        }
        if id.isEmpty {
            self.simpleAlert(title: "등록하기", message: "ID를 입력하세요")
        } else if pw.isEmpty {
            self.simpleAlert(title: "등록하기", message: "PASSWORD를 입력하세요")
        } else {
            // 검정 완료 전
            judgeTxt.text = "검증 중..."
            judgeTxt.textColor = UIColor(hexString: "#9b9b9b")
            SignService.judgeService(id: id, pwd: pw, onJudge:{ res in
                print(res)
                switch res {
                case"1":
                        self.valid()
                        break
                case"0":
                        self.simpleAlert(title: "시즌권 연동 안됨.", message: "웰팍 ID<->시즌권 연동을 먼저 해 주십시오.")
                        self.judgeTxt.text = "검증 미완료"
                        self.judgeTxt.textColor = UIColor(hexString: "#c72337")
                        self.judge = false
                        break
                case"-1":
                    self.simpleAlert(title: "잘못된 계정정보", message: "입력정보가 틀렸거나 등록된 계정이 아닙니다.")
                    self.judgeTxt.text = "검증 미완료"
                    self.judgeTxt.textColor = UIColor(hexString: "#c72337")
                    self.judge = false
                        break
                default:
                    self.simpleAlert(title: "알수없는 오류", message: "네트워크에 문제가 생겼습니다.")
                    self.judgeTxt.text = "검증 미완료"
                    self.judgeTxt.textColor = UIColor(hexString: "#c72337")
                    self.judge = false
                    break;
                }
            })
            
           
            // if 검증하기에서 통과한 경우
            
            
        }
    }
    
    func valid() {
        self.judgeTxt.text = "검증 완료"
        self.judgeTxt.textColor = UIColor(hexString: "#86B263")
        self.judge = true
        schoolPicker.isEnabled = true
        schoolPicker.placeholder = "학교명을 선택하세요"
        birthPicker.isEnabled = true
        birthPicker.placeholder = "생년월일을 선택하세요"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "#000000")
        self.pwTxt.delegate = self;
        self.idTxt.delegate = self;
        registerBtn.isEnabled = false
        schoolPicker.isEnabled = false
        schoolPicker.placeholder = "검증하기 완료 후 선택 가능"
        birthPicker.isEnabled = false
        birthPicker.placeholder = "검증하기 완료 후 선택 가능"
        backColor = registerBtn.backgroundColor
        registerBtn.backgroundColor = UIColor(hexString: "#9B9B9B")
        registerBtn.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        
        
        arrayInit()
        pickerInit()
    }
    @objc func register() {
        SignService.registerService(id: idTxt.text!, pwd: pwTxt.text!, univ: schoolPicker.text!) { (res) in
            print("res")
            print(res)
            if(res == "1") {
                //self.simpleAlert(title: "등록완료", message: "등록되었습니다.")
                self.dismiss(animated: true, completion: nil)
            } else {
                self.simpleAlert(title: "등록실패", message: "알수없는 오류가 발생하였습니다.")
            }
        }
        
    }
    
    @objc func selectSchool() {
        let row = schoolPickerView.selectedRow(inComponent: 0)
        schoolPicker.text = schoolList[row]
        view.endEditing(true)
    }
    
    @objc func selectBirth() {
        let year = birthList[0][birthPickerView.selectedRow(inComponent: 0)]
        let month = birthList[1][birthPickerView.selectedRow(inComponent: 1)]
        let day = birthList[2][birthPickerView.selectedRow(inComponent: 2)]
        birthPicker.text = year + month + day
        view.endEditing(true)
        
        registerBtn.isEnabled = true
        registerBtn.backgroundColor = backColor
    }
    
    func makeBar(type : Int) -> UIToolbar {
        let barFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        let bar = UIToolbar(frame : barFrame)
        let btnSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        if type == 1 {
            let btnDone = UIBarButtonItem(title: "선택", style: .done, target: self, action: #selector(selectSchool))
            bar.setItems([btnSpace, btnDone], animated: true)
        } else {
            let btnDone = UIBarButtonItem(title: "선택", style: .done, target: self, action: #selector(selectBirth))
            bar.setItems([btnSpace, btnDone], animated: true)
        }
        return bar
    }
    
    func arrayInit() {
        for year in 1987...2000 {
            birthList[0].append("\(year)")
        }
        for month in 1...12 {
            if month < 10 {
                birthList[1].append("0\(month)")
            } else {
                birthList[1].append("\(month)")
            }
        }
        for day in 1...31 {
            if day < 10 {
                birthList[2].append("0\(day)")
            } else {
                birthList[2].append("\(day)")
            }
        }
    }
    
    func pickerInit() {
        let schoolBar = makeBar(type: 1)
        let birthBar = makeBar(type: 2)
        
        schoolPickerView.delegate = self
        schoolPickerView.tag = 1
        schoolPicker.inputView = schoolPickerView
        schoolPicker.inputAccessoryView = schoolBar
        
        birthPickerView.delegate = self
        birthPickerView.tag = 2
        birthPicker.inputView = birthPickerView
        birthPicker.inputAccessoryView = birthBar
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true) // textBox는 textFiled 오브젝트 outlet 연동할때의 이름.
        
    }
}

extension RegisterVC : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView.tag {
        case 1:
            return 1
        case 2:
            return birthList.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return schoolList.count
        case 2:
            return birthList[component].count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return schoolList[row]
        case 2:
            return birthList[component][row]
        default:
            return ""
        }
    }
}
