//
//  InfoModel.m
//  QMMystery
//
//  Created by QiMENG on 15/6/1.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

#import "InfoModel.h"

@implementation InfoModel

- (void)setContent:(NSString *)content {
    
    _content = content;
//    _content = [content stringByReplacingOccurrencesOfString:@" 　　" withString:@"\n 　　"];
    
}

@end
