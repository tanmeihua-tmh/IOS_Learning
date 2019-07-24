//
//  ViewController.m
//  学生信息
//
//  Created by 王晨旭 on 2019/5/22.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"
#define FileName @"Student.plist"
@interface ViewController () <UITextFieldDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 注册通知监听器，监听键盘收起事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
   
}
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES]; // 退出键盘
}
- (NSString *) filePath
{
    // 获取应用程序的沙盒目录
    NSArray *array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[array objectAtIndex:0];
    return [path stringByAppendingPathComponent:FileName];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.nameField) {
        [self.birthdayField becomeFirstResponder];  // 切换到birthField
    }else if (textField == self.birthdayField){
        [self.numberField becomeFirstResponder]; // 切换到numberField
    }
    return YES;
}

-(void)alertViewWithTitle:(NSString *)title message:(NSString *)message CertainButtonTitle:(NSString *)buttonTitle{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title              message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defult = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:defult];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (IBAction)saveBtn:(id)sender {
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
        NSLog(@"%@",[self filePath]);
    }
    return;
}
@end
