//
//  main.m
//  ex_06
//
//  Created by 王晨旭 on 2019/4/3.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSFileManager *filemanager=[NSFileManager defaultManager];
        NSString *createFilePath=@"/Users/wangchenxu/Desktop";
        NSString *filename= [createFilePath stringByAppendingPathComponent:@"student"];
        NSString *str=@"传智播客，梦想起航的地方";
        NSData *data= [str dataUsingEncoding:NSUTF8StringEncoding];
        [filemanager createFileAtPath:filename contents:data attributes:nil];
        NSData *d=[NSData dataWithContentsOfFile:@"/Users/wangchenxu/Desktop/student"];
        NSString *strr=[[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
        NSLog(@"%@",strr);
        BOOL iswrite=[filemanager isWritableFileAtPath:@"/Users/wangchenxu/Desktop/students"];
        if(iswrite){
            NSLog(@"文件权限可写");
        }
        else {
            NSLog(@"文件权限不可写");
        }
    }
    return 0;
}
