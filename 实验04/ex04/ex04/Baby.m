//
//  Baby.m
//  ex04
//
//  Created by 王晨旭 on 2019/3/20.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Baby.h"
#import "Housekeeper.h"
@implementation Baby
-(void)hungry{
    [_delegate feedbaby];
}
@end
