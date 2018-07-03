//
//  DocumentIOManager.h
//  DocumentIO
//
//  Created by 沛沛 on 2018/6/29.
//  Copyright © 2018年 沛沛. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CacheStrategy) {
    CacheInBothMemoryAndDisk=0,
    CacheInMemoryOnly=1,
    CacheInDiskOnly=2,
};

typedef NS_ENUM(NSUInteger, FileType) {
    DocumentDirectory=0,
    CachesDirectory=1,
    LibraryDirectory=2,
    TemporaryDirectory=3,
    PreferencePanesDirectory=4
};

typedef NS_ENUM(NSUInteger, FilePath) {
    DefultFilePath=0,
    CachesDirectoryPath=1,
    LibraryDirectoryPath=2,
    TemporaryDirectoryPath=3,
    PreferencePanesDirectoryPath=4,
    HomeDirectoryPath=5
};

#define MethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

@interface DocumentIOManager : NSObject

//缓存位置（默认是document）
@property(nonatomic,assign) FileType fileType;

//写入文件是否覆写
@property(nonatomic,assign) BOOL enableOverwrite;

+(instancetype)managerWithCacheStrategy:(CacheStrategy)strategy;

-(NSString*)querySandBoxPath;
-(NSString *)querySandBoxPathWithFile:(FileType)fileType;
-(NSArray *)queryDocumentFromFile:(NSString*)filePath;

-(void)writeData:(id)data toFile:(NSString*)file;
-(void)writeArray:(NSArray*)arrayData toFile:(NSString*)file;
-(void)writeString:(NSString*)stringData toFile:(NSString*)file;
-(void)writeDictionary:(NSDictionary*)dictionaryData toFile:(NSString*)file;
-(void)writeNSData:(NSData*)nsData toFile:(NSString*)file;
@end
