//
//  ViewController.m
//  多点触控
//
//  Created by 王晨旭 on 2019/5/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *icons;
@end

@implementation ViewController
- (NSArray *)icons
{
    if (!_icons) {
        _icons = @[[UIImage imageNamed:@"spark_blue"], [UIImage imageNamed:@"spark_green"]];
    }
    return _icons;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self drawImageWithTouches:touches];
}
- (void)drawImageWithTouches:(NSSet *)touches
{
    int i = 0;
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView:self.view];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.icons[i]];
        imageView.center = location;
        [self.view addSubview:imageView];
        // 增加索引值
        i++;
        [UIView animateWithDuration:2.0f animations:^{
            imageView.alpha = 0.0f;
        }completion:^(BOOL finished) {
            [imageView removeFromSuperview];
        }];
    }
}



@end
