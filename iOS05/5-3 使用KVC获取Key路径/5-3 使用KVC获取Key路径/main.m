//
//  main.m
//  5-3 使用KVC获取Key路径
//
//  Created by wujz on 16/5/28.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");

        Person *p = [[Person alloc] init];
        // 使用KVC方式给name和age属性赋值
        [p setValue:@"Jay" forKey:@"name"];
        [p setValue:@28 forKey:@"age"];

        // 使用KVC方式获取对象p的属性
        NSLog(@"name = %@",[p valueForKey:@"name"]);
        NSLog(@"age = %d",[[p valueForKey:@"age"] intValue]);

        // 使用KVC方式给dog属性赋值
        [p setValue:[[Dog alloc] init] forKey:@"dog"];

        // 使用setValue:forKeyPath方法给dog属性的color属性赋值
        [p setValue:@1 forKeyPath:@"dog.color"];
        
        // 使用valueForKeyPath方法获取复合属性的值
        int color = [[p valueForKeyPath:@"dog.color"] intValue];
        switch (color) {
            case 0:
                NSLog(@"白色");
                break;

            case 1:
                NSLog(@"棕色");
                break;

            case 2:
                NSLog(@"黑色");
                break;
                
            default:
                NSLog(@"无");
                break;
        }
    }
    return 0;
}
