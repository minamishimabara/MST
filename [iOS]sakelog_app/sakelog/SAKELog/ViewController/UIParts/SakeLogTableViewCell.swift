//
//  SakeLogTableViewCell.swift
//  SAKELog
//
//  Created by taisuke kaneko on 2016/11/26.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import UIKit

class SakeLogTableViewCell: UITableViewCell {

    var sakeLogDataSource : SakeLogData!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productFurigana: UILabel!
    @IBOutlet weak var registDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setSakeLog(source: SakeLogData) {
        sakeLogDataSource = source
        productName.text = sakeLogDataSource.p_name
        productFurigana.text = sakeLogDataSource.p_furigana
        registDate.text = sakeLogDataSource.date
        productImage.image = #imageLiteral(resourceName: "DefaultSake")
        
        do {
            let imageData = try Data(contentsOf: URL(string: self.sakeLogDataSource.p_image)!)
            self.sakeLogDataSource.sakeImage = UIImage(data: imageData)
            self.productImage.image = UIImage(data: imageData)
        } catch {
            
        }        
    }
}
