//
//  ViewController.m
//  Tom
//
//  Created by 王晨旭 on 2019/4/10.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *tom;
- (IBAction)drink:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)drink:(id)sender {
    NSMutableArray *images=[NSMutableArray array];
    for(int i=0;i<81;i++){
        NSString *filename=[NSString stringWithFormat:@"drink_%02d.jpg",i];
        UIImage *image=[UIImage imageNamed:filename];
        [images addObject:image];
        
    }
    self.tom.animationImages=images;
    self.tom.animationRepeatCount=1;
    self.tom.animationDuration=8;
    [self.tom startAnimating];
}
@end
