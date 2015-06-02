//
//  ViewController.swift
//  QMMystery
//
//  Created by QiMENG on 15/6/1.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController , iCarouselDataSource,iCarouselDelegate {

    var dataArray :Array<String> = ["地理之谜","宇宙之谜","人类之谜","动物之谜","植物之谜"]
    var urlArray:Array<String> = ["ctrl.asp?id=1","ctrl.asp?id=2","ctrl.asp?id=3","ctrl.asp?id=4","ctrl.asp?id=5"]

    
    @IBOutlet weak var carouselView: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carouselView.delegate = self
        carouselView.dataSource = self
        carouselView.type = iCarouselType.CoverFlow2
        carouselView.clipsToBounds = true
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.carouselView.reloadData()
    }
    
    func numberOfItemsInCarousel(carousel: iCarousel!) -> Int {
        return dataArray.count
    }

    
    
    func carousel(carousel: iCarousel!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        
        var itemView = view as? UIImageView
        
        if let temp = itemView
        {

        }else
        {
            itemView = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width - 70, self.view.frame.size.height - 120))
            
            itemView?.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
            
            itemView?.contentMode = UIViewContentMode.ScaleAspectFill
            itemView?.clipsToBounds = true
            itemView?.layer.borderWidth = 1;
            itemView?.layer.borderColor = UIColor.whiteColor().CGColor
            itemView?.backgroundColor = UIColor.orangeColor()
            
            var label = UILabel(frame: CGRectMake(0, itemView!.frame.height - 40, itemView!.frame.width, 40))
            label.tag = 100
            label.textAlignment = NSTextAlignment.Center
            label.textColor = UIColor.whiteColor()
            label.backgroundColor = UIColor.clearColor()
            label.font = UIFont.boldSystemFontOfSize(24)
            itemView?.addSubview(label)
            
            
        }
        
        var label = itemView?.viewWithTag(100) as! UILabel
        
        label.text = dataArray[index]
        
        itemView?.image = UIImage(named: dataArray[index])
        
        return itemView
    }
    
    func carousel(carousel: iCarousel!, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        
//        return 1.0
        switch option {
            
            case .Wrap: return 1.0
            case .Spacing: return value * 1.05
            default: return value
        }
    }
    
    func carousel(carousel: iCarousel!, didSelectItemAtIndex index: Int) {
        
        self.performSegueWithIdentifier("ListTableController", sender: index)
        
    }

    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        
        self.carouselView.reloadData()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ListTableController" {
            
            var ctrl = segue.destinationViewController as! ListTableController
            
            let index = sender as! Int
            
            ctrl.title = dataArray[index]
            ctrl.kind = urlArray[index]
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

