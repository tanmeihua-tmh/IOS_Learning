//
//  Calculate.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/30.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Calculate.h"

@implementation Calculate

- (Calculate * _Nonnull (^)(CGFloat))add {
    return ^Calculate *(CGFloat number) {
        self.result += number;
        return self;
    };
}

- (Calculate * _Nonnull (^)(CGFloat))minus {
    return ^Calculate *(CGFloat number) {
        self.result -= number;
        return self;
    };
}

- (Calculate * _Nonnull (^)(CGFloat))multiply {
    return ^Calculate *(CGFloat number) {
        self.result *= number;
        return self;
    };
}

- (Calculate * _Nonnull (^)(CGFloat))divide {
    return ^Calculate *(CGFloat number) {
        self.result /= number;
        return self;
    };
}

- (CGFloat)makeCalculateMethod:(void(^)(Calculate *make)) block {
    return self.result;
}

@end
