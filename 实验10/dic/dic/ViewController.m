//
//  ViewController.m
//  dic
//
//  Created by 王晨旭 on 2019/4/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"
#import "Provinces.h"
@interface ViewController ()
@property (nonatomic,strong) NSArray *provinces;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@",self.provinces);
}
-(NSArray *)provinces{
    NSString *filepath = [[NSBundle mainBundle]pathForResource:@"provinces.plist" ofType:nil];
    NSArray *provincePlist = [NSArray arrayWithContentsOfFile:filepath];
    NSMutableArray *provinceM=[NSMutableArray array];
    for (NSDictionary *dict in provincePlist){
        Provinces *prov=[Provinces provinceWithDict:dict];
        [provinceM addObject:prov];
        _provinces=provinceM;
    }
    return _provinces;
}

@end
