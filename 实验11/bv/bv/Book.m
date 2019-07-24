//
//  Book.m
//  bv
//
//  Created by 王晨旭 on 2019/5/8.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Book.h"

@interface Book ()

@end

@implementation Book

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
