//
//  CalculatorViewController.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "CalculatorViewController.h"
#import "NSObject+Caiculator.h"
#import "MenuTableViewController.h"

@interface CalculatorViewController ()<UIPopoverPresentationControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstTF;
@property (weak, nonatomic) IBOutlet UITextField *secondTF;
@property (weak, nonatomic) IBOutlet UIButton *methodBtn;
@property (weak, nonatomic) IBOutlet UIButton *equalBtn;
@property (weak, nonatomic) IBOutlet UILabel *resultLB;

@end

@implementation CalculatorViewController {
    NSInteger _methodIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _methodIndex = 1;
    self.firstTF.delegate = self;
    self.secondTF.delegate = self;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)methodClick:(UIButton *)sender {
    MenuTableViewController *menu = [[MenuTableViewController alloc] init];
    menu.lists = @[@"➕",@"➖",@"✖️",@"➗"];
    menu.tableView.bounces = NO;
    menu.tableView.scrollEnabled = NO;
    menu.preferredContentSize =CGSizeMake(100,menu.lists.count * 44);
    
    menu.modalPresentationStyle =UIModalPresentationPopover;
    
    UIPopoverPresentationController *popVC = menu.popoverPresentationController;
    popVC.delegate =self;
    // 气泡依附于哪个view弹出
    
    popVC.sourceView = self.methodBtn;
    
    // 气泡从哪个位置弹出，是以按钮的上边中心点即（sender.width/2，0）为坐标原点。
    
    popVC.sourceRect =CGRectMake(self.methodBtn.width/2, 0, 0, 0);
    
    // > 箭头的指向（上，下，左，右）
    
    popVC.permittedArrowDirections =UIPopoverArrowDirectionDown;
    
    [self presentViewController:menu animated:YES completion:nil];
    __weak typeof(menu) weakMenu = menu;
    menu.block = ^(NSInteger index) {
        [self.view resignFirstResponder];
        [self.view endEditing:NO];
        self->_methodIndex = index+1;
        [self.methodBtn setTitle:weakMenu.lists[index] forState:UIControlStateNormal];
        [weakMenu dismissViewControllerAnimated:YES completion:nil];
        if (self.firstTF.text.length > 0 && self.secondTF.text.length > 0) {
            [self equalClick:self.equalBtn];
        }
    };
}
- (IBAction)equalClick:(UIButton *)sender {
    [self.view resignFirstResponder];
    [self.view endEditing:NO];
    CGFloat result = 0.0;
    if (_methodIndex == 1) {
        result = [NSObject makeCalculateMethod:^(Calculate * _Nonnull calculator) {
            calculator.add([self.firstTF.text floatValue]).add([self.secondTF.text floatValue]);
        }];
    }
    if (_methodIndex == 2) {
        result = [NSObject makeCalculateMethod:^(Calculate * _Nonnull calculator) {
            calculator.add([self.firstTF.text floatValue]).minus([self.secondTF.text floatValue]);
        }];
    }
    if (_methodIndex == 3) {
        result = [NSObject makeCalculateMethod:^(Calculate * _Nonnull calculator) {
            calculator.add([self.firstTF.text floatValue]).multiply([self.secondTF.text floatValue]);
        }];
    }
    if (_methodIndex == 4) {
        if ([self.secondTF.text floatValue] == 0) {
            [SVProgressHUD showErrorWithStatus:@"The divisor should not be equal to zero"];
            return;
        }
        result = [NSObject makeCalculateMethod:^(Calculate * _Nonnull calculator) {
            calculator.add([self.firstTF.text floatValue]).divide([self.secondTF.text floatValue]);
        }];
    }
    NSString *temp = [NSString stringWithFormat:@"%10.9f",result];
    self.resultLB.text = [self twoDecimalStringWithNumber:[NSDecimalNumber decimalNumberWithString:temp]];
}

- (NSString *)twoDecimalStringWithNumber:(NSDecimalNumber *)number
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.maximumFractionDigits = 8;//最多保留几位小数，就是几
    formatter.groupingSeparator = @"";
    return [formatter stringFromNumber:number];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    
    // 此处为不适配(如果选择其他,会自动视频屏幕,上面设置的大小就毫无意义了)
    
    return UIModalPresentationNone;
    
}

// MARK: UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length == 0 && [string isEqualToString:@"."]) {
        return NO;
    }
    
    if ([string isEqualToString:@"."] && [textField.text containsString:@"."]) {
        return NO;
    }
    
    if (textField.text.length >= 10) {
        return NO;
    }
    
    return YES;
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
