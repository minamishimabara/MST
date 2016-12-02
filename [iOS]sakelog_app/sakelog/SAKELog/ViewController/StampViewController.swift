//
//  StampViewController.swift
//  SAKELog
//
//  Created by taisuke kaneko on 2016/11/25.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class StampViewController: UIViewController {

    let NUM_HORIZONTAL_STAMP = 3
    let MAX_STAMP = 6
    
    var numberOfStamp : Int!
    var stampSizeUnitFloat : CGFloat!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var remainLabel: UILabel!
    
    @IBOutlet weak var readingButton: UIButton!
    var appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var stampImageViewArray : [UIImageView] = Array()
    
    @IBOutlet weak var stampView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remainLabel.text = ""
        numberOfStamp = UserDefaultsHelper.stamp
        if numberOfStamp > 0 {
            for i in 1...numberOfStamp {
                let stampImageView = UIImageView(frame: culculateImageViewPosition(at: i))
                stampImageView.image = #imageLiteral(resourceName: "ver1-00_mst_circle")
                stampImageView.contentMode = .scaleAspectFill
                stampView.addSubview(stampImageView)
                stampImageViewArray.append(stampImageView)
            }
        }
        statusLabel.text = "下のアイコンをタップして、\nスタンプをゲットしてください！"
        self.remainLabel.text = "あと\(MAX_STAMP-self.numberOfStamp)個で特典をGET！"
    }
    
    @IBAction func btnPress(_ sender: Any) {
        appDelegate.trigger = false
        statusLabel.text = "読み込み中..."
        readingButton.isEnabled = false
        self.statusLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        remainLabel.text = ""
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: {_ in
            self.readingButton.isEnabled = true
            if self.numberOfStamp == UserDefaultsHelper.stamp {
                self.statusLabel.text = "読み取れませんでした..."
            } else {
                self.statusLabel.text = "スタンプゲット！"
                self.statusLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                self.numberOfStamp = UserDefaultsHelper.stamp
                if self.numberOfStamp == self.MAX_STAMP {
                    let alert: UIAlertController = UIAlertController(title: "特典をゲット！\nおめでとう！", message: "", preferredStyle:  UIAlertControllerStyle.alert)
                    let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ (action: UIAlertAction!) -> Void in
                        self.numberOfStamp = 0
                        UserDefaultsHelper.stamp = 0
                        for imgView in self.stampImageViewArray {
                            imgView.removeFromSuperview()
                        }
                        self.stampImageViewArray.removeAll()
                        self.statusLabel.text = "下のアイコンをタップして、\nスタンプをゲットしてください！"
                        self.remainLabel.text = "あと\(self.MAX_STAMP-self.numberOfStamp)個で特典をGET！"
                    })
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    self.remainLabel.text = "あと\(self.MAX_STAMP-self.numberOfStamp)個で特典をGET！"
                }
                let stampImageView = UIImageView(frame: self.culculateImageViewPosition(at: self.numberOfStamp))
                stampImageView.image = #imageLiteral(resourceName: "ver1-00_mst_circle")
                stampImageView.contentMode = .scaleAspectFill
                self.stampView.addSubview(stampImageView)
                self.stampImageViewArray.append(stampImageView)
            }
        })
    }
    
    func culculateStampSizeUnit() -> CGFloat{
        let totalWidth = stampView.bounds.width
        return totalWidth / CGFloat(NUM_HORIZONTAL_STAMP)
    }
    
    func culculateImageViewPosition(at: Int) -> CGRect {
        
        if stampSizeUnitFloat == nil {
            stampSizeUnitFloat = culculateStampSizeUnit()
        }
        var pos = at - 1
        var x : CGFloat = 0.0
        var y : CGFloat = 0.0
        
        while pos >= NUM_HORIZONTAL_STAMP {
            pos = pos - NUM_HORIZONTAL_STAMP
            y += stampSizeUnitFloat
        }
        x = CGFloat(pos) * stampSizeUnitFloat
        
        return CGRect(x: x, y: y, width: stampSizeUnitFloat, height: stampSizeUnitFloat)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
