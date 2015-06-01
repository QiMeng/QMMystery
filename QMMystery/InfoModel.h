//
//  InfoModel.h
//  QMMystery
//
//  Created by QiMENG on 15/6/1.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoModel : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * content;

/**
 *  [Model]
 */
@property (nonatomic, retain) NSArray * others;

@end
