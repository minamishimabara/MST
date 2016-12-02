//
//  SakeLogDetailViewController.swift
//  SAKELog
//
//  Created by taisuke kaneko on 2016/11/26.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import UIKit

class SakeLogDetailViewController: UIViewController, UITextViewDelegate {

    var masterDataSource : SakeLogData!
    
    @IBOutlet weak var btnRate1: UIButton!
    @IBOutlet weak var btnRate2: UIButton!
    @IBOutlet weak var btnRate3: UIButton!
    @IBOutlet weak var btnRate4: UIButton!
    @IBOutlet weak var btnRate5: UIButton!

    @IBOutlet weak var memoField: UITextView!
    
    @IBOutlet weak var sakeImageView: UIImageView!
    
    @IBOutlet weak var p_name: UILabel!
    @IBOutlet weak var b_rice: UILabel!
    @IBOutlet weak var p_furigana: UILabel!
    @IBOutlet weak var p_best_temperature: UILabel!
    @IBOutlet weak var b_name: UILabel!
    @IBOutlet weak var captureLabel: UILabel!
    @IBOutlet weak var p_capacity: UILabel!
    @IBOutlet weak var p_acidity: UILabel!
    @IBOutlet weak var p_nihonshudo: UILabel!
    @IBOutlet weak var p_alcohol: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoField.delegate = self
        change(rate: masterDataSource.rate)
        change(memo: masterDataSource.memo)
        p_name.text = masterDataSource.p_name
        b_rice.text = masterDataSource.b_rice_polish
        p_furigana.text = masterDataSource.p_furigana
        p_best_temperature.text = masterDataSource.p_best_temperature
        b_name.text = masterDataSource.b_name
        captureLabel.text = masterDataSource.date
        p_capacity.text = masterDataSource.p_capacity
        p_acidity.text = masterDataSource.p_acidity
        p_nihonshudo.text = masterDataSource.p_nihonshudo
        p_alcohol.text = String(masterDataSource.p_alcohol)
        
        sakeImageView.image = masterDataSource.sakeImage
        sakeImageView.contentMode = .scaleAspectFill
    }
    
    deinit{
        update(memo: memoField.text)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView){
        scrollView.contentOffset.y = 500
    }
    
    func change(memo : String){
        memoField.text = memo
    }
    
    func change(rate : Int){
        switch rate {
        case 0:
            disableRate(btn: btnRate1)
            disableRate(btn: btnRate2)
            disableRate(btn: btnRate3)
            disableRate(btn: btnRate4)
            disableRate(btn: btnRate5)
        case 1:
            enableRate(btn: btnRate1)
            disableRate(btn: btnRate2)
            disableRate(btn: btnRate3)
            disableRate(btn: btnRate4)
            disableRate(btn: btnRate5)
        case 2:
            enableRate(btn: btnRate1)
            enableRate(btn: btnRate2)
            disableRate(btn: btnRate3)
            disableRate(btn: btnRate4)
            disableRate(btn: btnRate5)
        case 3:
            enableRate(btn: btnRate1)
            enableRate(btn: btnRate2)
            enableRate(btn: btnRate3)
            disableRate(btn: btnRate4)
            disableRate(btn: btnRate5)
        case 4:
            enableRate(btn: btnRate1)
            enableRate(btn: btnRate2)
            enableRate(btn: btnRate3)
            enableRate(btn: btnRate4)
            disableRate(btn: btnRate5)
        case 5:
            enableRate(btn: btnRate1)
            enableRate(btn: btnRate2)
            enableRate(btn: btnRate3)
            enableRate(btn: btnRate4)
            enableRate(btn: btnRate5)
        default: break
        }
    }
    
    func update(rate: Int){
        masterDataSource.rate = rate
        DatabaseUtil.shard.updateSakeLog(forColumnKey: DatabaseUtil.shard.C_RATE,
                                         value: rate,
                                         atID: masterDataSource.id)
    }
    func update(memo: String){
        masterDataSource.memo = memo
        DatabaseUtil.shard.updateSakeLog(forColumnKey: DatabaseUtil.shard.C_MEMO,
                                         value: memo,
                                         atID: masterDataSource.id)
    }
    
    func disableRate(btn:UIButton){
        btn.setImage(#imageLiteral(resourceName: "hage_disable"), for: .normal)
        btn.alpha = 0.3
    }
    func enableRate(btn:UIButton){
        btn.setImage(#imageLiteral(resourceName: "hage_enable"), for: .normal)
        btn.alpha = 1.0
    }
    
    @IBAction func btnRate0Touch(_ sender: Any) {
        change(rate: 0)
        update(rate: 0)
    }
    @IBAction func btnRate1Touch(_ sender: Any) {
        change(rate: 1)
        update(rate: 1)
    }
    @IBAction func btnRate2Touch(_ sender: Any) {
        change(rate: 2)
        update(rate: 2)
    }
    @IBAction func btnRate3Touch(_ sender: Any) {
        change(rate: 3)
        update(rate: 3)
    }
    @IBAction func btnRate4Touch(_ sender: Any) {
        change(rate: 4)
        update(rate: 4)
    }
    @IBAction func btnRate5Touch(_ sender: Any) {
        change(rate: 5)
        update(rate: 5)
    }
    @IBAction func btnRate6Touch(_ sender: Any) {
        change(rate: 5)
        update(rate: 5)
    }
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        update(memo: memoField.text)
    }
}
