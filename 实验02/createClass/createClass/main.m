//
//  main.m
//  createClass
//
//  Created by 王晨旭 on 2019/3/6.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculator.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Calculator *a=[Calculator new];
        double b=[a sum:2 :3];
        double c=[a sub:5 :2];
        double d=[a mul:3.5 :2];
        double e=[a div:6 :2];
        NSLog(@"%f,%f,%f,%f",b,c,d,e);
    }
    return 0;
}

