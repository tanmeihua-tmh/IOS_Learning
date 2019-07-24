//
//  main.m
//  单例模式
//
//  Created by 王晨旭 on 2019/5/15.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Singleton *singleton=[Singleton shareSingleton];
        NSLog(@"%@",singleton);
        Singleton *singleton2=[Singleton shareSingleton];
        NSLog(@"%@",singleton2);
    }
    return 0;
}
