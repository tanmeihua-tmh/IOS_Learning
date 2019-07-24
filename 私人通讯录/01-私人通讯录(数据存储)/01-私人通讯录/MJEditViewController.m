//
//  MJEditViewController.m
//  01-私人通讯录
//
//  Created by apple on 14-4-10.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJEditViewController.h"
#import "MJContact.h"

@interface MJEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
- (IBAction)edit:(UIBarButtonItem *)item;

- (IBAction)save;


@end

@implementation MJEditViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置数据
    self.nameField.text = self.contact.name;
    self.phoneField.text = self.contact.phone;
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
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
    self.saveBtn.enabled = (self.nameField.text.length && self.phoneField.text.length);
}

- (IBAction)edit:(UIBarButtonItem *)item {
    if (self.nameField.enabled) { // 点击的是"取消"
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        [self.view endEditing:YES];
        self.saveBtn.hidden = YES;
        
        item.title = @"编辑";
        
        // 还原回原来的数据
        self.nameField.text = self.contact.name;
        self.phoneField.text = self.contact.phone;
    } else { // 点击的是"编辑"
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        [self.phoneField becomeFirstResponder];
        self.saveBtn.hidden = NO;
        
        item.title = @"取消";
    }
}

/**
 *  保存
 */
- (IBAction)save {
    // 1.关闭页面
    [self.navigationController popViewControllerAnimated:YES];
    
    // 2.通知代理
    if ([self.delegate respondsToSelector:@selector(editViewController:didSaveContact:)]) {
        // 更新模型数据
        self.contact.name = self.nameField.text;
        self.contact.phone = self.phoneField.text;
        [self.delegate editViewController:self didSaveContact:self.contact];
    }
}
@end
