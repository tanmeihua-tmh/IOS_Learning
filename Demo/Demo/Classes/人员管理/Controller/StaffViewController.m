//
//  StaffViewController.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/27.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "StaffViewController.h"
#import "StaffInfo.h"
#import "NSString+PinYin.h"
#import "StaffDetailInfoViewController.h"

@interface StaffViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *staffs;
@property (nonatomic, strong) NSDictionary *staffDict;
@property (nonatomic, strong) NSArray *indexArray;// 索引数组

@end

@implementation StaffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initData];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kNavBarHeight);
        make.left.bottom.right.mas_equalTo(self.view);
    }];
    
    [self setupAddNavBarItem];
}

- (void)setupAddNavBarItem {
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = addItem;
}

- (void)initData {
    NSData *data = UserDefaultGet([UserDefaultGet(@"userName") stringByAppendingString:@"staff"])[UserDefaultGet(@"userName")];
    NSDictionary *dict = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:data error:nil];
    if ([[dict allKeys] count] > 0) {
        self.staffs = [[dict allKeys] arrayWithPinYinFirstLetterFormat];
        self.staffDict = dict;
    }else {
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        for (NSInteger i=0; i < 5; i++) {
            StaffInfo *info = [StaffInfo new];
            info.name = [NSString stringWithFormat:@"name--%ld",i];
            info.studentNumber = [NSString stringWithFormat:@"学号--%u",arc4random_uniform(100)+10];
            info.phoneNumber = [NSString stringWithFormat:@"15%u1111222%u",arc4random_uniform(10),arc4random_uniform(10)];
            info.QQNumber = [NSString stringWithFormat:@"%u1111222%u",arc4random_uniform(100),arc4random_uniform(10)];
            info.WeChatNumber = [NSString stringWithFormat:@"weChat --%u1111222%u",arc4random_uniform(100),arc4random_uniform(10)];
            info.emailNumber = [NSString stringWithFormat:@"%u1111222%u@qq.com",arc4random_uniform(100),arc4random_uniform(10)];
            [dictM setObject:info forKey:info.name];
            
        }
        NSData *infoData = [NSKeyedArchiver archivedDataWithRootObject:dictM.copy requiringSecureCoding:YES error:nil];
        UserDefaultSet(infoData, @"staffInfosDict");
        UserDefaultSet(@{UserDefaultGet(@"userName"): infoData}, [UserDefaultGet(@"userName") stringByAppendingString:@"staff"]);
        
        //        NSData *data = UserDefaultGet(@"staffInfosDict");
        //        NSDictionary *dict = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:UserDefaultGet(@"staffInfosDict") error:nil];
        
        self.staffs = [[dictM.copy allKeys] arrayWithPinYinFirstLetterFormat];
        self.staffDict = dictM.copy;
    }
    
    NSMutableArray *indexs = [NSMutableArray array];
    for (NSDictionary *dict in self.staffs) {
        [indexs addObject:dict[@"firstLetter"]];
    }
    self.indexArray = indexs.copy;
    [self.tableView reloadData];
}

- (void)addClick:(UIButton *)sender {
    StaffInfo *info = [StaffInfo new];
    info.name = @"";
    info.phoneNumber = @"";
    info.studentNumber = @"";
    info.QQNumber = @"";
    info.WeChatNumber = @"";
    info.emailNumber = @"";
    [self pushDetail:info IsAddMethod:YES];
}

-(NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.staffs[section][@"firstLetter"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.staffs.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.staffs[section][@"content"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *kStaffCellID = @"kStaffCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStaffCellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kStaffCellID];
    }
    StaffInfo *info = self.staffDict[self.staffs[indexPath.section][@"content"][indexPath.row]];
    cell.textLabel.text =  info.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StaffInfo *info = self.staffDict[self.staffs[indexPath.section][@"content"][indexPath.row]];
    [self pushDetail:info IsAddMethod:NO];
}

- (void)pushDetail:(StaffInfo *)info IsAddMethod:(BOOL)isAdd {
    StaffDetailInfoViewController *detailVC = [[StaffDetailInfoViewController alloc] init];
    detailVC.title = isAdd ? @"添加人员" : @"人员详情";
    detailVC.info = info;
    detailVC.block = ^{
        NSDictionary *dict = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:UserDefaultGet(@"staffInfosDict") error:nil];
        if ([[dict allKeys] count] > 0) {
            self.staffs = [[dict allKeys] arrayWithPinYinFirstLetterFormat];
            self.staffDict = dict;
        }
        NSMutableArray *indexs = [NSMutableArray array];
        for (NSDictionary *dict in self.staffs) {
            [indexs addObject:dict[@"firstLetter"]];
        }
        self.indexArray = indexs.copy;
        [self.tableView reloadData];
        if (isAdd) {
            [self.tableView setScrollsToTop:YES];
        }
    };
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    for (UIView *view in [tableView subviews]) {
        if ([view isKindOfClass:[NSClassFromString(@"UITableViewIndex") class]]) {
            [view setValue:[UIFont fontWithName:@"AmericanTypewriter" size:18] forKey:@"_font"];
            view.bounds = CGRectMake(0, 0, 30, 0);
            [view setBackgroundColor:[UIColor clearColor]];
        }
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithDictionary:self.staffDict];
        [tempDict removeObjectForKey:self.staffs[indexPath.section][@"content"][indexPath.row]];
        
        NSData *infoData = [NSKeyedArchiver archivedDataWithRootObject:tempDict.copy requiringSecureCoding:YES error:nil];
        UserDefaultSet(infoData, @"staffInfosDict");
        UserDefaultSet(@{UserDefaultGet(@"userName"): infoData}, [UserDefaultGet(@"userName") stringByAppendingString:@"staff"]);
        
//        NSDictionary *dict = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:UserDefaultGet(@"staffInfosDict") error:nil];
        NSData *data = UserDefaultGet([UserDefaultGet(@"userName") stringByAppendingString:@"staff"])[UserDefaultGet(@"userName")];
        NSDictionary *dict = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:data error:nil];
        
        self.staffs = [[dict allKeys] arrayWithPinYinFirstLetterFormat];
        self.staffDict = dict;
        [tableView reloadData];
    }
}

@end
