//
//  MJAddViewController.m
//  01-私人通讯录
//
//  Created by apple on 14-4-10.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJAddViewController.h"
#import "MJContact.h"

@interface MJAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)add;
@end

@implementation MJAddViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
    
    // 退出键盘
//    [self.nameField resignFirstResponder];
//    [self.view endEditing:YES];
}

/**
 *  控制器的view完全显示的时候调用
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 让姓名文本框成为第一响应者(叫出键盘)
    [self.nameField becomeFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  文本框的文字发生改变的时候调用
 */
- (void)textChange
{
    self.addBtn.enabled = (self.nameField.text.length && self.phoneField.text.length);
}

/**
 *  添加
 */
- (IBAction)add {
    // 1.关闭当前控制器
    [self.navigationController popViewControllerAnimated:YES];
    
    // 2.传递数据给上一个控制器(MJContactsViewController)
    // 2.通知代理
    if ([self.delegate respondsToSelector:@selector(addViewController:didAddContact:)]) {
        MJContact *contact = [[MJContact alloc] init];
        contact.name = self.nameField.text;
        contact.phone = self.phoneField.text;
        [self.delegate addViewController:self didAddContact:contact];
    }
}
@end
