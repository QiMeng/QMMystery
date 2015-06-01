//
//  Service.m
//  QMMystery
//
//  Created by QiMENG on 15/6/1.
//  Copyright (c) 2015年 QiMENG. All rights reserved.
//

#import "Service.h"

@implementation Service

+ (instancetype)sharedClient {
    static Service *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[Service alloc] initWithBaseURL:[NSURL URLWithString:kBaseURLString]];
        
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
                    [SVProgressHUD showErrorWithStatus:@"已链接wifi"];
                    
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"已链接wifi" message:nil delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                {
                    [SVProgressHUD showErrorWithStatus:@"网络中断.请检查网络设置."];
                }
                    break;
                default:
                    break;
            }
        }];
        
    });
    
    return _sharedClient;
}
#pragma mark - 数据转换成中文
+ (NSString *)encodingGBKFromData:(id)aData {
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *string = [[NSString alloc] initWithData:aData encoding:gbkEncoding];
    return string;
}
#pragma mark - 中文转换成GBK码
+ (NSString *)encodingBKStr:(NSString *)aStr {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    aStr = [aStr stringByAddingPercentEscapesUsingEncoding:enc];
    return aStr;
}

#pragma mark - 搜索
+ (id)search:(NSString *)aSearch
    withPage:(int)aPage
   withBlock:(void (^)(NSArray *array, NSError *error))block {
    
    return [[Service sharedClient] GET:[self encodingBKStr:[NSString stringWithFormat:@"search.asp?keys=%@&page=%d",aSearch,aPage]]
                            parameters:nil
                               success:^(NSURLSessionDataTask *task, id responseObject) {

                                   block([self parseResponse:responseObject],nil);
                                   
                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   
                                   [SVProgressHUD showErrorWithStatus:@"数据错误,请稍后再试"];
                                   
                               }];
}
#pragma mark - 类别列表
+ (id)kind:(NSString *)aKind withPage:(int)aPage withBlock:(void (^)(NSArray *array, NSError *error))block {
    
    return [[Service sharedClient] GET:[NSString stringWithFormat:@"%@&page=%d",aKind,aPage]
                            parameters:nil
                               success:^(NSURLSessionDataTask *task, id responseObject) {
                                   
                                   block([self parseResponse:responseObject],nil);
                                   
                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   [SVProgressHUD showErrorWithStatus:@"数据错误,请稍后再试"];
                               }];
    
}

+ (NSArray *)parseResponse:(id)response {
    
    NSMutableArray * mainArray = [NSMutableArray array];
    
    @autoreleasepool {
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithHTMLData:response
                                                                  encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)
                                                                     error:NULL];
        if (doc) {
            
            NSArray * trArray = [doc nodesForXPath:@"//table[@class='ctable']" error:NULL];

            for (GDataXMLElement * item0 in trArray) {

                NSArray * tr = [item0 elementsForName:@"tr"];

                for (GDataXMLElement * item1 in tr) {
                    
                    NSArray * td = [item1 elementsForName:@"td"];
                    
                    for (GDataXMLElement * item2 in td) {
                        
                        NSArray * a = [item2  elementsForName:@"a"];
                        
                        if (a) {
                            
                            GDataXMLElement * element = a[0];
                            
                            if ([element.stringValue isEqualToString:@"详情"]) {
                                continue;
                            }
                            
                            Model * m = [Model new];
                            
                            m.title = element.stringValue;
                            m.href = [[element attributeForName:@"href"] stringValue];

                            [mainArray addObject:m];
                        }
                    }
                }
            }
        }
    }
    
    return mainArray;
}

#pragma mark - 信息详情
+ (id)info:(NSString *)aInfo withBlock:(void (^)(InfoModel *infoModel, NSError *error))block {
    
    return [[Service sharedClient] GET:aInfo
                            parameters:nil
                               success:^(NSURLSessionDataTask *task, id responseObject) {

                                   block([self praseInfo:responseObject],nil);
                                   
                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   [SVProgressHUD showErrorWithStatus:@"数据错误,请稍后再试"];
                               }];
    
}
+ (InfoModel *)praseInfo:(id)response {
    
    InfoModel * model = [InfoModel new];
    
    @autoreleasepool {
        GDataXMLDocument * doc = [[GDataXMLDocument alloc]initWithHTMLData:response
                                                                  encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)
                                                                     error:NULL];
        if (doc)
        {
            
            NSArray * divArray = [doc nodesForXPath:@"//div[@class='cdiv']" error:NULL];
            
            if (divArray.count == 3)
            {
                {
                    GDataXMLElement * infoElement = divArray[1];
                    NSArray * pArray = [infoElement elementsForName:@"p"];
                    if (pArray.count ==2) {
                        model.title = ((GDataXMLElement *)pArray[0]).stringValue;
                        model.content = ((GDataXMLElement *)pArray[1]).stringValue;
                    }
                }
                {
                    NSMutableArray * others = [NSMutableArray array];
                    
                    GDataXMLElement * divElement = divArray[2];
                    NSArray * pArray = [divElement elementsForName:@"p"];
                    for (GDataXMLElement * item0 in pArray) {
                        
                        NSArray * a = [item0 elementsForName:@"a"];
                        
                        if (a.count == 2) {
                            
                            Model * m = [Model new];
                            [others addObject:m];
                            
                            m.title = item0.stringValue;
                            m.href = [[((GDataXMLElement *)a[1]) attributeForName:@"href"] stringValue];
                            
                        }
                    }
                    model.others = others;
                }
            }
        }
    }
    
    
    return model;
}



@end
