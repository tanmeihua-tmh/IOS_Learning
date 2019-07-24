//
//  ViewController.m
//  2-4 UIButton应用
//
//  Created by wujz on 16/4/17.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moveBtn:(id)sender {
    NSInteger tag = [sender tag];
    CGRect moveFrame = self.pictureUIImageView.frame;

    switch (tag) {
        case 1:
            moveFrame.origin.y -= 10;
            break;
        case 2:
            moveFrame.origin.x -= 10;
            break;
        case 3:
            moveFrame.origin.x += 10;
            break;
        case 4:
            moveFrame.origin.y += 10;
            break;
        default:
            break;
    }
    self.pictureUIImageView.frame = moveFrame;
}

- (IBAction)rotateBtn:(id)sender {
    NSInteger tag = [sender tag];

    CGAffineTransform rotate = self.pictureUIImageView.transform;

    if (tag == 5) {
//        rotate = CGAffineTransformMakeRotation(10/6.28);
        rotate = CGAffineTransformRotate(rotate, -10/6.28/4);
    }
    else{
        rotate = CGAffineTransformRotate(rotate, 10/6.28/4);
    }
    self.pictureUIImageView.transform = rotate;
}

- (IBAction)scaleBtn:(id)sender {
    NSInteger tag = [sender tag];

    CGAffineTransform scale = self.pictureUIImageView.transform;

    if (tag == 6) {
        scale = CGAffineTransformScale(scale, 0.9, 1.1);
    }
    else{
        scale = CGAffineTransformScale(scale, 0.9, 0.9);
    }
    self.pictureUIImageView.transform = scale;
}
@end
