//
//  ViewController.m
//  voice
//
//  Created by 王晨旭 on 2019/4/17.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageV;

@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.slider addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
}
-(void)valueChange:(UISlider*)slider0
{
    int count=4;
    float level=slider0.value;
    if(level>=0&&level<1.0/(count-1)){
        self.voiceImageV.image=[UIImage imageNamed:@"voice0.jpg"];
    }
    else if(level>=1.0/(count-1)&&level<2.0/(count-1)){
        self.voiceImageV.image=[UIImage imageNamed:@"voice1.jpg"];
    }
    else if(level>=2.0/(count-1)&&level<1){
        self.voiceImageV.image=[UIImage imageNamed:@"voice2.jpg"];
    }
    else if(level==1){
        self.voiceImageV.image=[UIImage imageNamed:@"voice3.jpg"];
    }
}

@end
