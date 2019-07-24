//
//  ViewController.h
//  2-4 UIButton应用
//
//  Created by wujz on 16/4/17.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *pictureUIImageView;

- (IBAction)moveBtn:(id)sender;

- (IBAction)rotateBtn:(id)sender;
- (IBAction)scaleBtn:(id)sender;
@end

