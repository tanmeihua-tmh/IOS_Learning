//
//  Physics+CoreDataProperties.m
//  coreData
//
//  Created by 王晨旭 on 2019/5/22.
//  Copyright © 2019 王晨旭. All rights reserved.
//
//

#import "Physics+CoreDataProperties.h"

@implementation Physics (CoreDataProperties)

+ (NSFetchRequest<Physics *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Physics"];
}

@dynamic name;
@dynamic pid;
@dynamic number;
@dynamic core;

@end
