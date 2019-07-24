//
//  main.m
//  ex04
//
//  Created by 王晨旭 on 2019/3/20.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Baby.h"
#import "Housekeeper.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Baby *b=[[Baby alloc]init];
        Housekeeper *js=[[Housekeeper alloc]init];
        Housekeeper *hs=[[Housekeeper alloc]init];
        js.name=@"教师";
        hs.name=@"护士";
        b.delegate=hs;
        [b hungry];
        b.delegate=js;
        [b hungry];
    }
    return 0;
}
