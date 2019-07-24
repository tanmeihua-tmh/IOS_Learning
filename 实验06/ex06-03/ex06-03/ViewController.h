//
//  ViewController.h
//  ex06-03
//
//  Created by 王晨旭 on 2019/4/4.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSString *symbol;
}
@property (weak, nonatomic) IBOutlet UILabel *output;
@property (weak, nonatomic) IBOutlet UITextField *input1;
@property (weak, nonatomic) IBOutlet UITextField *input2;
@property (weak, nonatomic) IBOutlet UITextField *input3;
- (IBAction)qingling:(id)sender;
- (IBAction)cunchu:(id)sender;
- (IBAction)duqu:(id)sender;
- (IBAction)dengyu:(id)sender;
@property (nonatomic,assign)int num1;
@property (nonatomic,assign)int num2;
@property (nonatomic,assign)int num3;
@end

