//
//  ListTableController.swift
//  QMMystery
//
//  Created by QiMENG on 15/6/1.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

import UIKit

class ListTableController: UITableViewController {

    var kind:String?
    var dataArray:Array<Model> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backageView = UIImageView(frame: self.view.bounds)
        backageView.contentMode = UIViewContentMode.ScaleAspectFill
        backageView.clipsToBounds = true
        backageView.image = UIImage(named: self.title!+"-暗")
        
        self.tableView.backgroundView = backageView

        SVProgressHUD.showWithStatus("正在加载", maskType: SVProgressHUDMaskType.Black)
        
        Service.kind(kind, withPage: 1) { (array, error) -> Void in
            
            self.dataArray += array as! Array<Model>
            
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        
        let model = dataArray[indexPath.row] as Model
        
        cell.textLabel?.text = model.title;
        

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let model = dataArray[indexPath.row] as Model
        
        self.performSegueWithIdentifier("DetaileTableController", sender: model)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "DetaileTableController" {
            
            var ctrl = segue.destinationViewController as! DetaileTableController
            ctrl.model = sender as? Model
        }
        
    }

}
