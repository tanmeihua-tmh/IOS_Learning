//
//  Taxi.h
//  createClass
//
//  Created by 王晨旭 on 2019/3/6.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Car.h"
NS_ASSUME_NONNULL_BEGIN

@interface Taxi :Car
{
    int _company;
}
-(void)accelerate;
-(void)printtickets;
@end

NS_ASSUME_NONNULL_END
