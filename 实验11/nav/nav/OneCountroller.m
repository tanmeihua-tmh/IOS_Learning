//
//  OneCountroller.m
//  nav
//
//  Created by 王晨旭 on 2019/5/8.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "OneCountroller.h"
#import "TwoCountroller.h"
@interface OneCountroller ()

@end

@implementation OneCountroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *dat = self.MyOneText.text;
    UIViewController *vc = segue.destinationViewController;
    if ([vc respondsToSelector:@selector(setSendValue:)]) {
        [vc setValue:dat forKey:@"sendValue"];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
