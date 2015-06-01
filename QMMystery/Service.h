//
//  Service.h
//  QMMystery
//
//  Created by QiMENG on 15/6/1.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

#import "QMMystery-Bridging-Header.h"

#import "Model.h"
#import "InfoModel.h"

@interface Service : AFHTTPSessionManager

+ (instancetype)sharedClient;

/**
 *  搜索
 *
 *  @param aSearch 搜索文本
 *  @param aPage   搜索页码
 */
+ (id)search:(NSString *)aSearch
    withPage:(int)aPage
   withBlock:(void (^)(NSArray *array, NSError *error))block;

/**
 *  类别列表
 *
 *  @param aKind 类别
 *  @param aPage 页码
 */
+ (id)kind:(NSString *)aKind withPage:(int)aPage withBlock:(void (^)(NSArray *array, NSError *error))block;

/**
 *  信息详情
 */
+ (id)info:(NSString *)aInfo withBlock:(void (^)(InfoModel *infoModel, NSError *error))block;

@end
