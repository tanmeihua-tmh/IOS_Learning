//
//  Singleton.h
//  单例模式
//
//  Created by 王晨旭 on 2019/5/15.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Singleton : NSObject
+(Singleton *)shareSingleton;
@end

NS_ASSUME_NONNULL_END
