//
//  SetTableController.swift
//  QMMystery
//
//  Created by QiMENG on 15/6/1.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

import UIKit

class SetTableController: UITableViewController,UMSocialUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 1 && indexPath.row == 0 {
            
            UIApplication.sharedApplication().openURL(NSURL(string: "itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id="+kAppID)!)
        }
        else if indexPath.section == 1 && indexPath.row == 1 {
            
            UMSocialSnsService.presentSnsIconSheetView(self,
                appKey: kUMengKey,
                shareText: "http://itunes.apple.com/us/app/id%@"+kAppID,
                shareImage: nil,
                shareToSnsNames: [UMShareToEmail,UMShareToSms,UMShareToSina,UMShareToTencent],
                delegate: self)
            
        }
        else if indexPath.section == 2 && indexPath.row == 0 {
            
//            SVProgressHUD.showWithStatus("努力加载", maskType: SVProgressHUDMaskType.Black)
//            
//            SimplePurchase.buyProduct(kIAPClear, block: { (error) -> Void in
//                
//                SVProgressHUD.dismiss()
//                
//                if error == nil {
//                    
//                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: kIAPClear)
//                    NSUserDefaults.standardUserDefaults().synchronize()
//                    
//                    self.clearIADLabel.text = "回复购买"
//                    
//                }else {
//                    
//                    let alert = UIAlertView(title: "购买失败",
//                        message: error.localizedDescription,
//                        delegate: nil,
//                        cancelButtonTitle: "取消")
//                    
//                    alert.show()
//                }
//                
//            })
        }
        
    }
}
