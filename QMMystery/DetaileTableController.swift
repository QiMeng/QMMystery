//
//  DetaileTableController.swift
//  QMMystery
//
//  Created by QiMENG on 15/6/2.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

import UIKit

class DetaileTableController: UITableViewController {

    var model:Model?
    var infoMod:InfoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backageView = UIImageView(frame: self.view.bounds)
        backageView.contentMode = UIViewContentMode.ScaleAspectFill
        backageView.clipsToBounds = true
        backageView.image = UIImage(named: "地理之谜"+"-暗")
        self.tableView.backgroundView = backageView
        
        self.tableView.tableFooterView = UIView()
        
        SVProgressHUD.showWithStatus("正在加载", maskType: SVProgressHUDMaskType.Black)
        
        Service.info(model?.href, withBlock: { (infoModel:InfoModel!, error) -> Void in
            
            self.infoMod = infoModel
            
            self.tableView.reloadData()
            
            SVProgressHUD.dismiss()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        if let infoModel:InfoModel = self.infoMod {
            return Int(2 + infoModel.others.count)
        }
        
        return 0
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 1 {
            if let content = self.infoMod?.content {
                
                let size = CGSize(width: Int(self.view.frame.width - 10), height: Int.max)
                let options : NSStringDrawingOptions = .UsesLineFragmentOrigin | .UsesFontLeading
                
                let boundingRect = content.boundingRectWithSize(size, options: options, attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(17)], context: nil)
                
                return boundingRect.height
                
            }
        }
        
        return 44
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let label = cell.viewWithTag(100) as! UILabel
        
        if indexPath.row == 0 {
            label.text = self.infoMod?.title
            label.textColor = UIColor.redColor()
            label.font = UIFont.boldSystemFontOfSize(18);
            label.textAlignment = NSTextAlignment.Center
        }
        
        else if indexPath.row == 1 {
            label.text = self.infoMod?.content
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.systemFontOfSize(17);
            label.textAlignment = NSTextAlignment.Left
        }
        else {
            let model = self.infoMod?.others[indexPath.row-2] as! Model
            label.text = model.title
            label.textColor = UIColor.blueColor()
            label.font = UIFont.systemFontOfSize(17);
            label.textAlignment = NSTextAlignment.Left
        }
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            
        }
        else if indexPath.row == 1 {
            
        }
        else {
            
            let model = self.infoMod?.others[indexPath.row-2] as! Model
            var ctrl = self.storyboard?.instantiateViewControllerWithIdentifier("DetaileTableController") as! DetaileTableController
            ctrl.model = model
            self.navigationController?.pushViewController(ctrl, animated: true)
            
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
