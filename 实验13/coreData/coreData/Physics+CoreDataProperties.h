//
//  Physics+CoreDataProperties.h
//  coreData
//
//  Created by 王晨旭 on 2019/5/22.
//  Copyright © 2019 王晨旭. All rights reserved.
//
//

#import "Physics+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Physics (CoreDataProperties)

+ (NSFetchRequest<Physics *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t pid;
@property (nullable, nonatomic, copy) NSString *number;
@property (nullable, nonatomic, copy) NSString *core;

@end

NS_ASSUME_NONNULL_END
