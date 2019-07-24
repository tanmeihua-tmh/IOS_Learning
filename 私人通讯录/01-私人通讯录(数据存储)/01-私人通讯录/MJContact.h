//
//  MJContact.h
//  01-私人通讯录
//
//  Created by apple on 14-4-10.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

/**
 copy : NSString\NSMutableString\block
 weak : 代理\UI控件
 strong : 其他OC对象
 assign : 基本数据类型(int\float)\枚举\结构体
 */

#import <Foundation/Foundation.h>

@interface MJContact : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phone;
@end
