//
//  DocumentIOCache.m
//  DocumentIO
//
//  Created by 沛沛 on 2018/6/29.
//  Copyright © 2018年 沛沛. All rights reserved.
//

#import "DocumentIOCache.h"

@implementation DocumentIOCache
+(instancetype)sharedInstance{
    static DocumentIOCache *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DocumentIOCache alloc]init];
    });
    return _instance;
}
@end
