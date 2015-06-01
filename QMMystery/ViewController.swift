//
//  ViewController.swift
//  QMMystery
//
//  Created by QiMENG on 15/6/1.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

import UIKit

class ViewController: UIViewController , iCarouselDataSource,iCarouselDelegate {

    var dataArray :Array<Model> = []
    
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
        return 5
    }

    
    
    func carousel(carousel: iCarousel!, viewForItemAtIndex index: Int, reusingView view: UIView!) -> UIView! {
        
        var itemView = view as? UIImageView
        
        if let temp = itemView
        {

        }else
        {
            itemView = UIImageView(frame: CGRectMake(0, 0, 250, 300))
            itemView?.layer.borderWidth = 1;
            itemView?.layer.borderColor = UIColor.blackColor().CGColor
            itemView?.backgroundColor = UIColor.orangeColor()
        }
        
        
        
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

