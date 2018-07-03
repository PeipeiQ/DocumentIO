//
//  DocumentIOManager.m
//  DocumentIO
//
//  Created by 沛沛 on 2018/6/29.
//  Copyright © 2018年 沛沛. All rights reserved.
//

#import "DocumentIOManager.h"
#import "DocumentIOCache.h"
#import "DocumentIOCacheInDisk.h"
#import "DocumentIOCacheInMemory.h"



@interface DocumentIOManager()

@end

@implementation DocumentIOManager

//初始化
+(instancetype)managerWithCacheStrategy:(CacheStrategy)strategy{
    static DocumentIOManager *_instance;
    switch (strategy) {
        case CacheInBothMemoryAndDisk:
            _instance = (DocumentIOCache*)[DocumentIOCache sharedInstance];
            break;
        case CacheInDiskOnly:
            _instance = (DocumentIOCacheInDisk*)[DocumentIOCacheInDisk sharedInstance];
            break;
        case CacheInMemoryOnly:
            _instance = (DocumentIOCacheInMemory*)[DocumentIOCacheInMemory sharedInstance];
            break;
        default:
            _instance = [[DocumentIOManager alloc]init];
            break;
    }
    return _instance;
}



//沙盒路径
-(NSString *)querySandBoxPath{
    return NSHomeDirectory();
}

//沙盒文件夹路径
-(NSString *)querySandBoxPathWithFile:(FileType)fileType{
    switch (fileType) {
        case DocumentDirectory:
            return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
            break;
        case CachesDirectory:
            return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            break;
        case LibraryDirectory:
            return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
            break;
        case TemporaryDirectory:
            return NSTemporaryDirectory();
            break;
        case PreferencePanesDirectory:
            return NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES).firstObject;
            break;
        default:return @"no such file";break;
    }
}

//获取文件夹下的所有文件
-(NSArray *)queryDocumentFromFile:(NSString*)filePath{
    return [[NSFileManager defaultManager]contentsOfDirectoryAtPath:filePath error:nil];
}

-(void)writeData:(id)data toFile:(NSString*)file{  MethodNotImplemented(); }
-(void)writeArray:(NSArray*)arrayData toFile:(NSString*)file{ MethodNotImplemented(); }
-(void)writeString:(NSString*)stringData toFile:(NSString*)file{ MethodNotImplemented(); }
-(void)writeDictionary:(NSDictionary*)dictionaryData toFile:(NSString*)file{ MethodNotImplemented(); }
-(void)writeNSData:(NSData*)nsData toFile:(NSString*)file{ MethodNotImplemented(); }






@end
