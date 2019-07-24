//
//  Book.h
//  bv
//
//  Created by 王晨旭 on 2019/5/8.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : UIViewController
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *detail;

- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype) bookWithDict:(NSDictionary *)dict;

+ (NSArray *)books;
@end

NS_ASSUME_NONNULL_END
