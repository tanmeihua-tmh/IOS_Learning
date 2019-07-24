//
//  ViewController.m
//  UIButton
//
//  Created by 王晨旭 on 2019/4/10.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
- (IBAction)run:(id)sender;
- (IBAction)rotate:(id)sender;
- (IBAction)scale:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)run:(id)sender {
    CGRect tmpframe=self.img.frame;
    NSInteger tag2=[sender tag];
    switch(tag2){
        case1:
            tmpframe.origin.y-=10;
            self.img.frame=tmpframe;
            break;
        case2:
            tmpframe.origin.y+=10;
            self.img.frame=tmpframe;
            break;
        case3:
            tmpframe.origin.x-=10;
            self.img.frame=tmpframe;
            break;
        case4:
            tmpframe.origin.x+=10;
            self.img.frame=tmpframe;
            break;
        default:
            break;
    }
}

- (IBAction)rotate:(id)sender {
    CGAffineTransform tf=self.img.transform;
    NSInteger tagg=[sender tag];
    if(tagg==5){
        self.img.transform=CGAffineTransformRotate(tf, M_PI_4*(-1));
    }
    else{
        self.img.transform=CGAffineTransformRotate(tf, M_PI_4*1);
    }
    
}

- (IBAction)scale:(id)sender {
    CGAffineTransform tm=self.img.transform;
    NSInteger tag1=[sender tag];
    if(tag1==7){
        CGAffineTransform temtransform=CGAffineTransformScale(tm, 1.2, 1.2);
        self.img.transform=temtransform;
    }else{
        CGAffineTransform temtransform=CGAffineTransformScale(tm, 0.8, 0.8);
        self.img.transform=temtransform;
    }
}
@end
