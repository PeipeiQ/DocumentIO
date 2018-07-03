//
//  DocumentIOCacheInMemory.m
//  DocumentIO
//
//  Created by 沛沛 on 2018/6/29.
//  Copyright © 2018年 沛沛. All rights reserved.
//

#import "DocumentIOCacheInMemory.h"

@implementation DocumentIOCacheInMemory

+(instancetype)sharedInstance{
    static DocumentIOCacheInMemory *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DocumentIOCacheInMemory alloc]init];
    });
    return _instance;
}

-(instancetype)init{
    if (self=[super init]) {
        
    }
    return self;
}

-(void)writeData:(id)data toFile:(NSString *)file{
    
}

@end
