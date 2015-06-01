//
//  ViewController.swift
//  QMMystery
//
//  Created by QiMENG on 15/6/1.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController , iCarouselDataSource,iCarouselDelegate {

    var dataArray :Array<String> = ["植物","动物","人类","宇宙","地理"]
    
    var dataDic:Dictionary<String,String>=["植物":"","动物":"","人类":"","宇宙":"","地理":""]
    
    @IBOutlet weak var carouselView: iCarousel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carouselView.delegate = self
        carouselView.dataSource = self
        carouselView.type = iCarouselType.CoverFlow2
        carouselView.clipsToBounds = true
//        carouselView.wrapEnabled = true
        // Do any additional setup after loading the view, typically from a nib.
        
//        SVProgressHUD.showWithStatus("正在加载", maskType: SVProgressHUDMaskType.Black)
//        
////        Service.search("太阳", withPage: 1) { (array, error) -> Void in
////            
////            self.dataArray += array as! Array<Model>
////            
////            SVProgressHUD.dismiss()
////        }
//
//        Service.kind("ctrl.asp?id=1", withPage: 1) { (array, error) -> Void in
//            
//            SVProgressHUD.dismiss()
//        }
//
//        
//        Service.info("esc.asp?id=456", withBlock: { (infoModel:InfoModel!, error) -> Void in
//            
//            SVProgressHUD.dismiss()
//        })
        
        
        
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
        
        label.text = dataArray[index] + "之谜"
        
        
        itemView?.image = UIImage(named: dataArray[index]+".jpg")
        
        return itemView
    }
    
    func carousel(carousel: iCarousel!, didSelectItemAtIndex index: Int) {
        
        println(index)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

