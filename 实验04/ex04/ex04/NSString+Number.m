//
//  NSString+Number.m
//  ex04
//
//  Created by 王晨旭 on 2019/3/20.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "NSString+Number.h"

@implementation NSString (Number)
+(int)capitalCount:(NSString *)str
{
    int count=0;
    for(int i=0;i<str.length;i++){
        unichar c= [str characterAtIndex:i];
        if(c>='A'&&c<='Z'){
            count++;
        }
        
    }
    return count;
}
@end
