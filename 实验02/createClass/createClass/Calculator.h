//
//  Calculator.h
//  createClass
//
//  Created by 王晨旭 on 2019/3/6.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Calculator : NSObject
-(double)sum:(double)num1 :(double)num2;
-(double)sub:(double)num1 :(double)num2;
-(double)mul:(double)num1 :(double)num2;
-(double)div:(double)num1 :(double)num2;
@end

NS_ASSUME_NONNULL_END
