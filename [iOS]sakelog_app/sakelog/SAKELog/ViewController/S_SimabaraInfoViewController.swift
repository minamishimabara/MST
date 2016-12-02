//
//  S_SimabaraInfoViewController.swift
//  SAKELog
//
//  Created by taisuke kaneko on 2016/11/26.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import UIKit

class S_SimabaraInfoViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    let S_SIMABARA_INFO_URL : String = "http://grepyrk.jimdo.com/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.loadRequest(URLRequest(url:URL(string:S_SIMABARA_INFO_URL)!))
        backButton.isEnabled = false
        nextButton.isEnabled = false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        ProgressUtil.showProgress()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        ProgressUtil.closeProgress()
        if webView.canGoBack {
            backButton.isEnabled = true
        } else {
            backButton.isEnabled = false
        }
        if webView.canGoForward {
            nextButton.isEnabled = true
        } else {
            nextButton.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        webView.goBack()
    }
    @IBAction func nextButtonPress(_ sender: Any) {
        webView.goForward()
    }
}
