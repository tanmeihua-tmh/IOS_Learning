//
//  Animal.h
//  ex03
//
//  Created by 王晨旭 on 2019/3/13.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Animal : NSObject
{
    int weight;
    int age;
}
-(void)setWeight:(int)weight;
-(int)getWeight;
-(void)setAge:(int)age;
-(int)getAge;
-(void)run;
-(void)eat;
@end

NS_ASSUME_NONNULL_END
