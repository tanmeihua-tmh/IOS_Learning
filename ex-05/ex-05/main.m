//
//  main.m
//  ex-05
//
//  Created by 王晨旭 on 2019/3/27.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *ma=[NSMutableArray arrayWithCapacity:7];
        [ma addObject:@"SUN"];
        [ma addObject:@"MON"];
        [ma addObject:@"TUE"];
        [ma addObject:@"THU"];
        [ma addObject:@"FRI"];
        [ma addObject:@"SAT"];
        for(NSObject *object in ma){
            NSLog(@"%@",object);
        }
        [ma insertObject:@"WED" atIndex:3];
        for(NSObject *object in ma){
            NSLog(@"%@",object);
        }
        }
    return 0;
}
