//
//  TopViewController.swift
//  SAKELog
//
//  Created by 金子 太祐 on 2016/11/20.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import UIKit
import SafariServices

class TopViewController: UIViewController {

    private static let SETTING_IB_NAME = "SettingViewController"
    private static let SETTING_IB_ID = "SettingViewStoryBoard"
    
    private static let YOSHIDAYA_URL = "http://bansho.ocnk.net"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaultsHelper.isFirstLaunch {
            presentSettingVC()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentSettingVC() {
        let settingIB : UIStoryboard = UIStoryboard(name: TopViewController.SETTING_IB_NAME, bundle: nil)
        let settingVC = settingIB.instantiateViewController(withIdentifier: TopViewController.SETTING_IB_ID)
        present(settingVC, animated: true, completion: nil)
    }
    
    @IBAction func btnSettingPress(_ sender: Any) {
        presentSettingVC()
    }
    
    @IBAction func pressBuyPanel(_ sender: Any) {
        let safariView : SFSafariViewController = SFSafariViewController(url: URL(string: TopViewController.YOSHIDAYA_URL)!)
        self.present(safariView, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != nil{
            switch segue.identifier! {
            case "toSakeLog": break
                //ProgressUtil.showProgress()
            default:
                break
            }
        }
    }
}
