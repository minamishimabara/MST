//
//  InfoViewController.swift
//  SAKELog
//
//  Created by 金子 太祐 on 2016/11/12.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    let SHUZO_INFO_URL : String = "http://www.iwi-web.com/mst/"
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        webView.loadRequest(URLRequest(url: URL(string: SHUZO_INFO_URL)!))
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
    
    
    @IBAction func backButtonPress(_ sender: Any) {
        webView.goBack()
    }
    @IBAction func nextButtonPress(_ sender: Any) {
        webView.goForward()
    }
}
