//
//  SettingsViewController.swift
//  SAKELog
//
//  Created by 金子 太祐 on 2016/11/20.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var agePicker: UIPickerView!
    @IBOutlet weak var ageSelectField: UIView!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var sexSelect: UISegmentedControl!

    @IBOutlet weak var ageSelectViewAlignBottomConstraint: NSLayoutConstraint!
    
    let ageArray = ["10代未満","10代","20代","30代","40代","50代","60代","70代以上"]

    override func viewDidLoad() {
        super.viewDidLoad()
        ageTextField.delegate = self
        agePicker.delegate = self
        agePicker.dataSource = self
        
        if UserDefaultsHelper.isFirstLaunch {
            UserDefaultsHelper.isFirstLaunch = false
            self.navigationItem.title = "初回設定"
        }
        
        sexSelect.selectedSegmentIndex = UserDefaultsHelper.sex.rawValue
        ageTextField.text = ageArray[UserDefaultsHelper.age.rawValue]
        
    }
    
    @IBAction func didChangeSex(_ sender: UISegmentedControl) {
        switch sexSelect.selectedSegmentIndex {
        case 0:
            UserDefaultsHelper.sex = SEX.MALE
        case 1:
            UserDefaultsHelper.sex = SEX.FEMALE
        case 2:
            UserDefaultsHelper.sex = SEX.OTHER
        default: break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        showPicker()
        return false
    }
    @IBAction func closeSetting(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressDone(_ sender: Any) {
        hiddenPicker()
        self.ageTextField.text = ageArray[self.agePicker.selectedRow(inComponent: 0)]
        switch agePicker.selectedRow(inComponent: 0) {
        case 0:
            UserDefaultsHelper.age = AGE.UNDER10
        case 1:
            UserDefaultsHelper.age = AGE.GEN10
        case 2:
            UserDefaultsHelper.age = AGE.GEN20
        case 3:
            UserDefaultsHelper.age = AGE.GEN30
        case 4:
            UserDefaultsHelper.age = AGE.GEN40
        case 5:
            UserDefaultsHelper.age = AGE.GEN50
        case 6:
            UserDefaultsHelper.age = AGE.GEN60
        case 7:
            UserDefaultsHelper.age = AGE.OVER60
        default: break
            
        }
    }
    
    func showPicker() {
        ageSelectViewAlignBottomConstraint.constant = ageSelectField.bounds.height
        UIView.animate(withDuration: 0.5, animations: {()->Void in
            self.view.layoutIfNeeded()
        })
    }
    
    func hiddenPicker() {
        ageSelectViewAlignBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.5, animations: {()->Void in
            self.view.layoutIfNeeded()
        })
    }
    
    //表示列
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //表示個数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 8
    }
    
    //表示内容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ageArray[row] as String
    }
}
