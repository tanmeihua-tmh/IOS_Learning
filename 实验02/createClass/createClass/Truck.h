//
//  Truck.h
//  createClass
//
//  Created by 王晨旭 on 2019/3/6.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Car.h"

NS_ASSUME_NONNULL_BEGIN

@interface Truck : Car
{
    int _loadWeight;
}
-(void)brake;
-(void)unload;
@end

NS_ASSUME_NONNULL_END
