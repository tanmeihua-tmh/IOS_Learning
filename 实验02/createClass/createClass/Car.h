//
//  Car.h
//  createClass
//
//  Created by 王晨旭 on 2019/3/6.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Car : NSObject
{
    @public
    int _color;
}
-(void)brake;
-(void)accelerate;
@end

NS_ASSUME_NONNULL_END
