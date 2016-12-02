//
//  SakeLogViewController.swift
//  SAKELog
//
//  Created by 金子 太祐 on 2016/11/12.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import UIKit

class SakeLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sakeLogTableView: UITableView!
    
    let toDetailViewSegueIdentifier = "toDetail"
    
    var sakeLogArray : [SakeLogData]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sakeLogTableView.delegate = self
        sakeLogTableView.dataSource = self
        
        let nib = UINib(nibName: "SakeLogTableViewCell", bundle: nil)
        sakeLogTableView.register(nib, forCellReuseIdentifier: "SakeLogCell")
        
        sakeLogArray = DatabaseUtil.shard.selectSakeLog()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**********/
    // - MARK: tableview delegate
    /**********/
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SakeLogCell")! as! SakeLogTableViewCell
        cell.setSakeLog(source: sakeLogArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sakeLogArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: toDetailViewSegueIdentifier, sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! SakeLogDetailViewController
        detailVC.masterDataSource = sakeLogArray[sender as! Int]
    }
}
