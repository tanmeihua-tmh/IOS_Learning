//
//  ViewController.m
//  更改价格
//
//  Created by 王晨旭 on 2019/5/15.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"
#import "Movie.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIButton *updateButton;


@property (nonatomic,strong) Movie *movie;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movie=[[Movie alloc]init];
    [self.movie addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionNew context:nil];
    
}
-(IBAction)update{
    [self.movie setValue:@"90元" forKey:@"price"];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"price"]){
        self.priceLabel.text=[self.movie valueForKeyPath:@"price"];
    }
    
}
-(void)dealloc{
    [self removeObserver:self forKeyPath:@"price"];
}
@end

