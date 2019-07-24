//
//  ViewController.m
//  SQLite
//
//  Created by 王晨旭 on 2019/5/22.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"
#import<sqlite3.h>
@interface ViewController ()

@end

@implementation ViewController
static sqlite3 *db = NULL;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    // 创建数据库路径
    NSString *dataBasePath = [docDir stringByAppendingPathComponent:@"database1.sqlite"];
    NSLog(@"数据库路径：%@", dataBasePath);
    
    // 是数据库的句柄，表示数据库象征，是操作数据库的实例对象。
    // 如果数据库存在就会返回数据库，如果数据库不存在，则会创建一个新的数据库返回
    int result = sqlite3_open([dataBasePath UTF8String], &db);
    // 判断数据库是否打开成功
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功");
        NSLog(@"%@",dataBasePath);
    }else {
        NSLog(@"打开数据库失败");
    }
    
    const char  *sql="CREATE TABLE IF NOT EXISTS t_students(id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL,  age INTEGER NOT NULL,number text NOT NULL,course text NOT NULL);";
    char *errmsg= NULL;
    result = sqlite3_exec(db, sql, NULL, NULL, &errmsg);
    if (result==SQLITE_OK) {
        NSLog(@"创表成功");
    }else {
        NSLog(@"创表失败--%s--%s--%d",errmsg,__FILE__,__LINE__);
    }
    const char  *sql1="CREATE TABLE IF NOT EXISTS t_teachers(id integer PRIMARY KEY AUTOINCREMENT,name text NOT NULL,  age INTEGER NOT NULL,phonenum text NOT NULL);";
    char *ermsg= NULL;
    result = sqlite3_exec(db, sql1, NULL, NULL, &errmsg);
    if (result==SQLITE_OK) {
        NSLog(@"创表成功");
    }else {
        NSLog(@"创表失败--%s--%s--%d",ermsg,__FILE__,__LINE__);
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)save:(id)sender {
        
        NSString *name=self.name.text;
        int age=[self.age.text intValue];
        NSString *number=self.number.text;
    NSString *course=self.course.text;
        if (name && age && number&&course) {
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_students(name, age,number,course)VALUES ('%@', %d,'%@','%@');", name, age,number,course];
            char *error = nil;
            // 2.执行插入sql语句
            sqlite3_exec(db, sql.UTF8String, NULL, NULL, &error);
            if (error) {
                
                [self alertViewWithTitle:@"提示" message:@"添加失败" CertainButtonTitle:@"确定"];
            }else
            {
                
                [self alertViewWithTitle:@"提示" message:@"保存成功" CertainButtonTitle:@"确定"];
            }
            
        }else{
            [self alertViewWithTitle:@"提示" message:@"请将信息填写完整" CertainButtonTitle:@"确定"];
        }
}

- (IBAction)read:(id)sender {
    const char *sql = "SELECT name, age  FROM t_students;";
    sqlite3_stmt *stmt; // 用于提取数据的
    // 1.做查询前的准备, 检查sql语句是否正确
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
    if (result == SQLITE_OK) {// 准备完成, 没有错误
        // 2.提取查询到的数据到stmt, 一次提取一条
        // 如果返回值为SQLITE_ROW, 就代表提取到了一条记录
        while(sqlite3_step(stmt) == SQLITE_ROW)
        {
            // 3.取出提取到的记录(数据)中的第0列的数据
            const unsigned char *name = sqlite3_column_text(stmt, 0);
            int age = sqlite3_column_int(stmt, 1);
            NSLog(@"%s %d", name, age);
            self.readname=[NSString stringWithFormat:@"%s", name];

            self.readage=[NSString stringWithFormat:@"%d", age];
        }
    }
    sqlite3_close(db);
}

- (IBAction)readt:(id)sender {
    const char *sql = "SELECT name, age  FROM t_teachers;";
    sqlite3_stmt *stmt; // 用于提取数据的
    // 1.做查询前的准备, 检查sql语句是否正确
    int result = sqlite3_prepare_v2(db, sql, -1, &stmt, NULL);
    if (result == SQLITE_OK) {// 准备完成, 没有错误
        // 2.提取查询到的数据到stmt, 一次提取一条
        // 如果返回值为SQLITE_ROW, 就代表提取到了一条记录
        while(sqlite3_step(stmt) == SQLITE_ROW)
        {
            // 3.取出提取到的记录(数据)中的第0列的数据
            const unsigned char *name = sqlite3_column_text(stmt, 0);
            int age = sqlite3_column_int(stmt, 1);
            NSLog(@"%s %d", name, age);
            self.readname=[NSString stringWithFormat:@"%@", name];
            
            self.readage=[NSString stringWithFormat:@"%d", age];
        }
    }
    sqlite3_close(db);
}

- (IBAction)savet:(id)sender {
    NSString *name=self.tname.text;
    int age=[self.tage.text intValue];
    NSString *phonenum=self.phonenum.text;
    if (name && age && phonenum) {
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_teachers(name, age,phonenum)VALUES ('%@', %d,'%@');", name, age,phonenum];
        char *error = nil;
        // 2.执行插入sql语句
        sqlite3_exec(db, sql.UTF8String, NULL, NULL, &error);
        if (error) {
            
            [self alertViewWithTitle:@"提示" message:@"添加失败" CertainButtonTitle:@"确定"];
        }else
        {
            
            [self alertViewWithTitle:@"提示" message:@"保存成功" CertainButtonTitle:@"确定"];
        }
        
    }else{
        [self alertViewWithTitle:@"提示" message:@"请将信息填写完整" CertainButtonTitle:@"确定"];
    }
}
-(void)alertViewWithTitle:(NSString *)title message:(NSString *)message CertainButtonTitle:(NSString *)buttonTitle{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title              message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defult = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:defult];
    //显示
    [self presentViewController:alert animated:YES completion:nil];
}
@end
