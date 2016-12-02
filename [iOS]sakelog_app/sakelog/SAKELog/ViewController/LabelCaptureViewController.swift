//
//  LabelCaptureViewController.swift
//  SAKELog
//
//  Created by 金子 太祐 on 2016/11/12.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import UIKit
import KIFastQR
import AFNetworking

class LabelCaptureViewController: UIViewController, KIFastQRCaptureDelegate {
    
    @IBOutlet weak var cameraView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let fastQR = KIFastQRCaptureView(frame: self.view.frame)
        fastQR.startCapture(with: self)
        self.view.addSubview(fastQR)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fastQRView(_ fastQRView: UIView!, captureOutput obtainedString: String!) {
        _ = navigationController?.popViewController(animated: true)
        RequestUtil().requestSakeName(withID: obtainedString)
    }
    
    /*
    @IBAction func cameraStart(_ sender : AnyObject){
        
        let sourceType : UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        } else {
        }
    }
    
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            cameraView.contentMode = .scaleAspectFit
            cameraView.image = pickedImage
        }
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
     */

}
