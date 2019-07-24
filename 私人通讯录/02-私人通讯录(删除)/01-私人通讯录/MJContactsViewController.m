//
//  MJContactsViewController.m
//  01-私人通讯录
//
//  Created by apple on 14-4-10.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJContactsViewController.h"
#import "MJAddViewController.h"
#import "MJEditViewController.h"
#import "MJContact.h"
#import "MJContactCell.h"

// 文件路径
#define MJContactsFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.data"]

@interface MJContactsViewController () <UIActionSheetDelegate, MJAddViewControllerDelegate, MJEditViewControllerDelegate>
- (IBAction)logout:(id)sender;
@property (nonatomic, strong) NSMutableArray *contacts;
@end

@implementation MJContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 添加一个删除item到导航栏的右边
    UIBarButtonItem *addItem = self.navigationItem.rightBarButtonItem;
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteClick)];
    self.navigationItem.rightBarButtonItems = @[deleteItem, addItem];
}

- (void)deleteClick
{
    // 让tableView进入编辑状态
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
//    self.tableView.editing = !self.tableView.isEditing;
}

- (NSMutableArray *)contacts
{
    if (_contacts == nil) {
        // 1.从文件中读取联系人数据
        _contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:MJContactsFilepath];
        
        // 2.如果数组为nil
        if (_contacts == nil) { // 文件不存在
            _contacts = [NSMutableArray array];
        }
    }
    return _contacts;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    MJContactCell *cell = [MJContactCell cellWithTableView:tableView];
    
    // 2.设置cell的数据
    cell.contact = self.contacts[indexPath.row];
    
    return cell;
}

#pragma mark - tableView的代理方法
/**
 *  如果实现了这个方法,就自动实现了滑动删除的功能
 *  点击了删除按钮就会调用
 *  提交了一个编辑操作就会调用(操作:删除\添加)
 *  @param editingStyle 编辑的行为
 *  @param indexPath    操作的行号
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) { // 提交的是删除操作
        // 1.删除模型数据
        [self.contacts removeObjectAtIndex:indexPath.row];
        
        // 2.刷新表格
        // 局部刷新某些行(使用前提:模型数据的行数不变)
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        // 3.归档
        [NSKeyedArchiver archiveRootObject:self.contacts toFile:MJContactsFilepath];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // 1.修改模型数据
        MJContact *contact = [[MJContact alloc] init];
        contact.name = @"jack";
        contact.phone = @"10086";
        [self.contacts insertObject:contact atIndex:indexPath.row + 1];
        
        // 2.刷新表格
        NSIndexPath *nextPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[nextPath] withRowAnimation:UITableViewRowAnimationBottom];
//        [self.tableView reloadData];
    }
}

/**
 *  当tableView进入编辑状态的时候会调用,询问每一行进行怎样的操作(添加\删除)
 */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row %2 ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleInsert;
}

//- (void)setName:(NSString *)name phone:(NSString *)phone
//{
//    NSLog(@"MJContactsViewController-%@-%@", name, phone);
//}

/**
 *  注销
 */
- (IBAction)logout:(id)sender {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"确定要注销?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
}

#pragma mark - actionsheet的代理方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) return;
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  执行跳转之前会调用
 *  在这个方法中,目标控制器的view还没有被创建
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id vc = segue.destinationViewController;
    
    if ([vc isKindOfClass:[MJAddViewController class]]) { // 如果是跳转到添加联系人的控制器
        // 设置下一个控制器(添加联系人的控制器)的代理
        MJAddViewController *addVc = vc;
        addVc.delegate = self;
    } else if ([vc isKindOfClass:[MJEditViewController class]]) { // 如果是跳转到查看(编辑)联系人的控制器
        MJEditViewController *editVc = vc;
        // 取得选中的那行
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        editVc.contact = self.contacts[path.row];
        editVc.delegate = self;
    }
}

#pragma mark - MJAddViewController的代理方法
- (void)addViewController:(MJAddViewController *)addVc didAddContact:(MJContact *)contact
{
    // 1.添加模型数据
    [self.contacts addObject:contact];
    
    // 2.刷新表格
    [self.tableView reloadData];
    
    // 3.归档数组
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:MJContactsFilepath];
}

#pragma mark - MJEditViewController的代理方法
- (void)editViewController:(MJEditViewController *)editVc didSaveContact:(MJContact *)contact
{
    // 刷新表格
    [self.tableView reloadData];
    
    // 归档数组
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:MJContactsFilepath];
}
@end
