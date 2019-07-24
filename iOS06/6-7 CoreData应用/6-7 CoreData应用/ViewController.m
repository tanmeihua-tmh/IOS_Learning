//
//  ViewController.m
//  6-7 CoreData应用
//
//  Created by wujz on 16/6/4.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Employee.h"

@interface ViewController ()
@property(strong,nonatomic)NSManagedObjectContext *context;
@end

@implementation ViewController

#pragma mark 模糊查询
- (IBAction)likeSearcher:(id)sender{
    // 查询
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];

    // 过滤
    // 1.查询以wang开头员工
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@",@"wang"];

    // 2.以si 结尾
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name ENDSWITH %@",@"si"];

    // 3.名字包含 g
    //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name CONTAINS %@",@"g"];

    // 4.like 以si结尾
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name like %@",@"li*"];
    request.predicate = pre;

    //读取信息
    NSError *error = nil;
    NSArray *emps = [self.context executeFetchRequest:request error:&error];
    if (!error) {
        NSLog(@"emps: %@",emps);
        for (Employee *emp in emps) {
            NSLog(@"%@ %@ %@",emp.name,emp.age,emp.height);
        }
    }else{
        NSLog(@"%@",error);
    }
}

#pragma mark 更新员工信息
- (IBAction)updateEmployee:(id)sender {
    // 把wangwu的身高更改成 1.7
    // 1.查找wangwu
    NSArray *emps = [self findEmployeeWithName:@"wangwu"];

    // 2.更新身高
    if (emps.count == 1) {
        Employee *emp = emps[0];
        emp.height = @1.7;
    }

    // 3.同步（保存）到数据
    [self.context save:nil];
}

-(NSArray *)findEmployeeWithName:(NSString *)name{
    // 1.查找员工
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];

    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@",name];
    request.predicate = pre;


    return [self.context executeFetchRequest:request error:nil];

}

#pragma mark 删除员工
- (IBAction)deleteEmployee:(id)sender {
    [self deleteEmployeeWithName:@"lisi"];
}

-(void)deleteEmployeeWithName:(NSString *)name{
    // 删除zhangsan
    // 1.查找到zhangsan
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];

    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@",name];
    request.predicate = pre;

    // 2.删除zhangsan
    NSArray *emps = [self.context executeFetchRequest:request error:nil];

    for (Employee *emp in emps) {
        NSLog(@"删除员工的人 %@",emp.name);
        [self.context deleteObject:emp];
    }

    // 3.用context同步下数据库
    //所有的操作暂时都是在内存里，调用save 同步数据库
    [self.context save:nil];
}

#pragma mark 读取员工信息
- (IBAction)readEmployee:(id)sender {

    //创建一个请求对象 （填入要查询的表名-实体类）
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Employee"];

    // 过滤查询
    // 查找张三 并且身高大于1.8
    //    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@ AND height > %@",@"zhangsan",@(1.8)];
    //    request.predicate = pre;

    //排序 以身高进行升序
    //    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:NO];
    //    request.sortDescriptors = @[sort];

    // 分页查询 总共13条数据 每页显示5条数据
    //第一页的数据
    request.fetchLimit = 5;
    request.fetchOffset = 10;


    //读取信息
    NSError *error = nil;
    NSArray *emps = [self.context executeFetchRequest:request error:&error];
    if (!error) {
        NSLog(@"emps: %@",emps);
        for (Employee *emp in emps) {
            NSLog(@"%@ %@ %@",emp.name,emp.age,emp.height);
        }
    }else{
        NSLog(@"%@",error);
    }
}

#pragma mark 添加员工信息
- (IBAction)addEmployee:(id)sender {

    // 创建员工

    Employee *emp1 = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];

    // 设置员工属性
    emp1.name = @"lisi";
    emp1.age = @28;
    emp1.height = @2.10;

    //保存 - 通过上下文操作
    NSError *error = nil;
    [self.context save:&error];
    if (!error) {
        NSLog(@"success");
    }else{
        NSLog(@"%@",error);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建一个数据库 company.sqlite
    // 数据库要一张表 员工表 （name,age,heigt）
    // 往数据添加员工信息
    // CoreData
    [self setupContext];

}

-(void)setupContext{

    // 1.上下文 关联Company.xcdatamodeld 模型文件
    //    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    //@wujz
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];

    // 关联模型文件

    // 创建一个模型对象
    // 传一个nil 会把 bundle下的所有模型文件 关联起来
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];

    // 持久化存储调度器
    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];

    // 存储数据库的名字
    NSError *error = nil;

    // 获取docment目录
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];

    // 数据库保存的路径
    NSString *sqlitePath = [doc stringByAppendingPathComponent:@"company.sqlite"];
    NSLog(@"文件路径：%@", sqlitePath);

    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:&error];

    context.persistentStoreCoordinator = store;

    self.context = context;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // 创建员工
    for (int i = 0; i < 10; i++) {
        Employee *emp1 = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:self.context];

        // 设置员工属性
        emp1.name = [NSString stringWithFormat:@"wangwu %d",i];
        emp1.age = @(28 + i);
        emp1.height = @2.10;

        //保存 - 通过上下文操作
        NSError *error = nil;
        [self.context save:&error];
        if (!error) {
            NSLog(@"success");
        }else{
            NSLog(@"%@",error);
        }
        
    }
    
}
@end