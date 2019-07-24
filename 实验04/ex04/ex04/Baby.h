//
//  Baby.h
//  ex04
//
//  Created by 王晨旭 on 2019/3/20.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Housekeeper;
NS_ASSUME_NONNULL_BEGIN

@interface Baby : NSObject
-(void)hungry;
@property(nonatomic,strong) Housekeeper *delegate;
@end

NS_ASSUME_NONNULL_END
