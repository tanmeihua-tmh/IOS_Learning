//
//  main.m
//  5-2 观察者模式(KVC)
//
//  Created by wujz on 16/5/28.
//  Copyright © 2016年 zucc. All rights reserved.
//

//  使用KVC操作属性

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");

        Person *p = [[Person alloc]init];
        [p setValue:@"张三" forKey:@"name"];
        [p setValue:@20 forKey:@"age"];

        NSLog(@"Nmae = %@", [p valueForKey:@"name"]);
        NSLog(@"Age = %@", [p valueForKey:@"age"]);
    }
    return 0;
}
