//
//  ViewController.m
//  6-3 plist属性列表存储数据
//
//  Created by wujz on 16/6/4.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "ViewController.h"

#define FileName @"Student.plist"  // 属性列表宏

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self read];
    // 让nameField成为第一个响应者
    //    [self.nameField becomeFirstResponder];
    // 注册通知监听器，监听键盘弹起事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 注册通知监听器，监听键盘收起事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

// 键盘弹起时触发的方法
-(void)keyboardWillShow:(NSNotification *)notification{
    // 开启视图升起的动画效果
    [UIView beginAnimations:@"keyboardWillShow" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 获取视图View的位置
    CGRect rect=self.view.frame;
    rect.origin.y=-60;
    self.view.frame=rect;
    // 结束动画
    [UIView commitAnimations];
}

// 键盘关闭时调用的方法
-(void)keyboardWillHide:(NSNotification *)notification
{
    // 开始视图下降动画效果
    [UIView beginAnimations:@"keyboardWillHide" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 获取主视图View的位置
    CGRect rect = self.view.frame;
    rect.origin.y = 0;
    // 恢复主视图View的位置
    self.view.frame = rect;
    // 结束动画
    [UIView commitAnimations];
}

-(void)dealloc{
    // 移除通知监听器
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/*读取plist文件的信息*/
- (void)read
{
    // 从文件初始化NSDictionary对象
    NSDictionary *dict = [NSDictionary
                          dictionaryWithContentsOfFile:[self filePath]];
    NSDictionary *Lily = [dict objectForKey:@"Student"];
    // 将plist文件的信息显示到对应的文本框和分段控件
    if (Lily) {
        self.nameField.text = [Lily objectForKey:@"Name"];
        self.birthdayField.text = [Lily objectForKey:@"Birthday"];
        self.sexSegment.selectedSegmentIndex =
        [[Lily objectForKey:@"Sex"] intValue];
        self.numberField.text = [Lily objectForKey:@"Number"];
    }
}
// 获取plist文件的路径
- (NSString *) filePath
{
    // 获取应用程序的沙盒目录
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[array objectAtIndex:0];
    return [path stringByAppendingPathComponent:FileName];
}

// 屏幕单击事件响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES]; // 退出键盘
}

// 按回车键，切换文本框的输入焦点
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameField) {
        [self.birthdayField becomeFirstResponder];  // 切换到birthField
    }else if (textField == self.birthdayField){
        [self.numberField becomeFirstResponder]; // 切换到numberField
    }
    return YES;
}

// 定义一个提示用户信息的方法
-(void)alertViewWithTitle:(NSString *)title message:(NSString *)message CertainButtonTitle:(NSString *)buttonTitle{
//    UIAlertView 已经被废弃，不再使用
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title              message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defult = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:nil];

    [alert addAction:defult];
    //显示
    [self presentViewController:alert animated:YES completion:nil];

}

- (IBAction)saveBtn:(id)sender {
    // 获取填入表格中的数据
    NSString *name=self.nameField.text;
    NSString *birthday=self.birthdayField.text;
    NSInteger sex=self.sexSegment.selectedSegmentIndex;
    NSString *number=self.numberField.text;

    // 判断表格填写是否完整
    if(!name.length||!birthday.length||!number.length){
        [self alertViewWithTitle:@"提示" message:@"信息不完整，请重新填写" CertainButtonTitle:@"确定"];
        return;
    }
    [self.view endEditing:YES];

    // 创建字典对象封装学生信息
    NSMutableDictionary *Student=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [Student setObject:name forKey:@"Name"];
    [Student setObject:birthday forKey:@"Birthday"];
    [Student setObject:[NSNumber numberWithInteger:sex] forKey:@"Sex"];
    [Student setObject:number forKey:@"Number"];
    [dic setObject:Student forKey:@"Student"];
    // 将字典对象转为属性列表持久保存在plist文件中
    if ([dic writeToFile:[self filePath] atomically:YES]) {
        [self alertViewWithTitle:@"提示" message:@"保存成功" CertainButtonTitle:@"确定"];
    }
    return;
}
@end
