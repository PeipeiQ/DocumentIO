//
//  DocumentIOCacheInDisk.m
//  DocumentIO
//
//  Created by 沛沛 on 2018/6/29.
//  Copyright © 2018年 沛沛. All rights reserved.
//

#import "DocumentIOCacheInDisk.h"

@implementation DocumentIOCacheInDisk

+(instancetype)sharedInstance{
    static DocumentIOCacheInDisk *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DocumentIOCacheInDisk alloc]init];
    });
    return _instance;
}

-(instancetype)init{
    if (self=[super init]) {
        self.fileType = DocumentDirectory;
        self.enableOverwrite = YES;
    }
    return self;
}



-(void)writeString:(NSString *)stringData toFile:(NSString *)file{
    file = [self judgeFileNameExtensionWithFileName:file extensions:@[@"txt",@"doc"]];
    
    NSString *path = [[self querySandBoxPathWithFile:self.fileType] stringByAppendingPathComponent:file];
    //是否覆写
    if (!self.enableOverwrite) {
        NSMutableString *oldString = [[NSMutableString alloc]initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        if (oldString) {
            stringData= [oldString stringByAppendingString:stringData];
        }
    }
    [stringData writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

-(void)writeArray:(NSArray *)arrayData toFile:(NSString *)file{
    file = [self judgeFileNameExtensionWithFileName:file extensions:@[@"plist"]];
    
    NSString *path = [[self querySandBoxPathWithFile:self.fileType] stringByAppendingPathComponent:file];
    if (!self.enableOverwrite) {
        NSMutableArray *oldArr = [[NSMutableArray alloc]initWithContentsOfFile:path];
        arrayData= [oldArr arrayByAddingObjectsFromArray:arrayData];
    }
    
    [arrayData writeToFile:path atomically:true];
}

-(void)writeDictionary:(NSDictionary *)dictionaryData toFile:(NSString *)file{
    file = [self judgeFileNameExtensionWithFileName:file extensions:@[@"plist"]];
    
    NSString *path = [[self querySandBoxPathWithFile:self.fileType] stringByAppendingPathComponent:file];
    if (!self.enableOverwrite) {
        NSMutableDictionary *oldDic = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
        [oldDic addEntriesFromDictionary:dictionaryData];
        dictionaryData = oldDic;
    }
    [dictionaryData writeToFile:path atomically:true];
}


-(void)writeNSData:(NSData *)nsData toFile:(NSString *)file{
    NSString *path = [[self querySandBoxPathWithFile:self.fileType] stringByAppendingPathComponent:file];
    [nsData writeToFile:path atomically:true];
}

//检测后缀名的可用性
-(NSString*)judgeFileNameExtensionWithFileName:(NSString*)fileName extensions:(NSArray*)extensions{
    NSString *extensionsString = [extensions componentsJoinedByString:@"|"];
    NSString *regex = [NSString stringWithFormat:@"^.*\\.(%@)$",extensionsString];
    NSPredicate *judgeFileName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if([judgeFileName evaluateWithObject:fileName]){
        return fileName;
    }else{
        fileName = [fileName stringByAppendingPathExtension:extensions[0]];
        return fileName;
    }
}


@end
