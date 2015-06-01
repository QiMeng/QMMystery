//
//  ViewController.swift
//  QMMystery
//
//  Created by QiMENG on 15/6/1.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataArray :Array<Model> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SVProgressHUD.showWithStatus("正在加载", maskType: SVProgressHUDMaskType.Black)
        
//        Service.search("太阳", withPage: 1) { (array, error) -> Void in
//            
//            self.dataArray += array as! Array<Model>
//            
//            SVProgressHUD.dismiss()
//        }

//        Service.kind("ctrl.asp?id=1", withPage: 1) { (array, error) -> Void in
//            
//            SVProgressHUD.dismiss()
//        }

        
        Service.info("esc.asp?id=456", withBlock: { (infoModel:InfoModel!, error) -> Void in
            
            SVProgressHUD.dismiss()
        })
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

