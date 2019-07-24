//
//  main.m
//  沙盒
//
//  Created by 王晨旭 on 2019/5/22.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *appPath = NSHomeDirectory();
        NSLog(@"沙盒路径：%@", appPath);
        
        NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docPath = [array objectAtIndex:0];
        NSLog(@"Document 路径：%@", docPath);
        
        NSString *tmpPath = NSTemporaryDirectory();
        NSLog(@"tmp路径：%@", tmpPath);
        
        NSArray *libArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *libPath = [libArray objectAtIndex:0];
        NSLog(@"Library 路径：%@", libPath);
    }
    return 0;
}
