//
//  ViewController.m
//  6-5 对象归档
//
//  Created by wujz on 16/6/4.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

#import "ViewController.h"
#import"Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)read:(id)sender {
    // 1.获取文件路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"person.arc"];
    // 2.从指定文件读取对象
    Person *person = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@",person);
}

- (IBAction)save:(id)sender {
    // 1.创建对象
    Person *person = [[Person alloc] init];
    person.name = @"Jack";
    person.age = 28;
    person.height = 180;
    person.weight = 135;
    // 2.获取路径
    NSString *path =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"person.arc"];
    // 3.将对象person归档
    [NSKeyedArchiver archiveRootObject:person toFile:filePath];
}

@end
