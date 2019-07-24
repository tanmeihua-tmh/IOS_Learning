//
//  ViewController.m
//  coreData
//
//  Created by 王晨旭 on 2019/5/22.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "Physics+CoreDataClass.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pid;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UITextField *core;
- (IBAction)insertData:(id)sender;
- (IBAction)selectData:(id)sender;
- (IBAction)deleteData:(id)sender;
- (IBAction)updateData:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *rname;
@property (weak, nonatomic) IBOutlet UILabel *rnum;
@property(strong,nonatomic)NSManagedObjectContext *context;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self context];
}


- (IBAction)insertData:(id)sender {
    Physics *ph1 = [NSEntityDescription insertNewObjectForEntityForName:@"Physics" inManagedObjectContext:self.context];
    
    
     NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    ph1.pid=[f numberFromString:self.pid.text];
    ph1.name = self.name.text;
    ph1.number =self.number.text;
    ph1.core = self.core.text;
    
    //保存 - 通过上下文操作
    NSError *error = nil;
    [self.context save:&error];
    if (!error) {
        NSLog(@"success");
    }else{
        NSLog(@"%@",error);
    }
}

- (IBAction)selectData:(id)sender {
     NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Physics"];
    request.fetchLimit = 5;
    request.fetchOffset = 10;
    NSError *error = nil;
    NSArray *phys = [self.context executeFetchRequest:request error:&error];
    if (!error) {
        NSLog(@"phys: %@",phys);
        for (Physics *phy in phys) {
            self.rname.text=phy.name;
            self.rnum.text=phy.number;
            break;
        }
    }else{
        NSLog(@"%@",error);
    }
    
}

- (IBAction)deleteData:(id)sender {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Physics"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@",self.name.text];
    request.predicate = pre;
    
    NSArray *phys = [self.context executeFetchRequest:request error:nil];
    
    for (Physics *phy in phys) {
        NSLog(@"删除的人 %@",phy.name);
        [self.context deleteObject:phy];
    }
    
    // 3.用context同步下数据库
    //所有的操作暂时都是在内存里，调用save 同步数据库
    [self.context save:nil];
}

- (IBAction)updateData:(id)sender {
    NSArray *phys = [self findPhysicsWithName:@"wcx"];
    
    // 2.更新身高
    if (phys.count == 1) {
        Physics *phy = phys[0];
        phy.number = self.number.text;
    }
    
    
    // 3.同步（保存）到数据
    [self.context save:nil];
}
-(NSArray *)findPhysicsWithName:(NSString *)name{
    // 1.查找员工
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Physics"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"name=%@",name];
    request.predicate = pre;
    
    
    return [self.context executeFetchRequest:request error:nil];
    
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
    NSString *sqlitePath = [doc stringByAppendingPathComponent:@"coreData.db"];
    NSLog(@"文件路径：%@", sqlitePath);
    
    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:sqlitePath] options:nil error:&error];
    
    context.persistentStoreCoordinator = store;
    
    self.context = context;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    // 创建员工
    for (int i = 0; i < 10; i++) {
        Physics *emp1 = [NSEntityDescription insertNewObjectForEntityForName:@"Physics" inManagedObjectContext:self.context];
        
        // 设置员工属性
        emp1.name = [NSString stringWithFormat:@"wangwu %d",i];
        emp1.number= [NSString stringWithFormat:@"12345 %d",i];
        emp1.core=[NSString stringWithFormat:@"x %d",i];
        
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
