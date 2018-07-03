//
//  ViewController.m
//  DocumentIO
//
//  Created by 沛沛 on 2018/6/21.
//  Copyright © 2018年 沛沛. All rights reserved.
//

#import "ViewController.h"
#import "DocumentIOManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DocumentIOManager *manager = [DocumentIOManager managerWithCacheStrategy:CacheInDiskOnly];
    manager.fileType = CachesDirectory;
    //[manager writeArray:@[@1,@3] toFile:@"app"];
    //[manager writeString:@"bbbbb" toFile:@"app5docx"];
    manager.enableOverwrite = false;
    UIImage *image = [UIImage imageNamed:@"111.jpg"];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    [manager writeNSData:data toFile:@"ppp"];
    
}






@end
