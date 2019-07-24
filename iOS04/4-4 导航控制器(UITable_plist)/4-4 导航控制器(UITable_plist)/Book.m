//
//  Book.m
//  4-4 导航控制器(UITable_plist)
//
//  Created by wujz on 16/5/22.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "Book.h"

@interface Book ()
@end

@implementation Book

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


}

- (instancetype) initWithDict:(NSDictionary *)dict{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }

    return self;
}

+ (instancetype) bookWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

+ (NSArray *)books{
    NSString *fileName = @"book.plist";
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *mutArr = [NSMutableArray array];
    
    for (NSDictionary *tmpDict in array) {
        [mutArr addObject:[Book bookWithDict:tmpDict]];
    }
    return mutArr;
}

@end
