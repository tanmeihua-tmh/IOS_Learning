//
//  ViewController.m
//  cell
//
//  Created by 王晨旭 on 2019/5/4.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"
#import "NewCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *news;

@end

@implementation ViewController

-(NSArray *)news{
    
    
    if (!_news) {
        NSString *path=[[NSBundle mainBundle]pathForResource:@"news.plist" ofType:nil];
        _news=[NSArray arrayWithContentsOfFile:path];
    }
    return _news;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight=70;
    
}
-(BOOL)prefersStatusBarHidden{
    
    return YES;
}

#pragma mark dataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.news.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"newCell"];
    NSDictionary *dic=self.news[indexPath.row];
    
    cell.title.text=dic[@"title"];
    cell.author.text=dic[@"author"];
    cell.comment.text=[NSString stringWithFormat:@"评论:%@",dic[@"comments"]];
    cell.icon.image=[UIImage imageNamed:dic[@"icon"]];
    
    return cell;
}




@end
