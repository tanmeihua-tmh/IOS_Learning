//
//  EventViewController.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "EventViewController.h"
#import "SDCycleScrollView.h"
#import "EventTableViewCell.h"
#import "EventInfo.h"
#import "EventDetailInfoViewController.h"
#import "MenuTableViewController.h"
#import "TimeDownViewController.h"
#import "CalculatorViewController.h"

@interface EventViewController ()<UITableViewDelegate,UITableViewDataSource,UIPopoverPresentationControllerDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong) NSArray *events;
@property (nonatomic, strong) NSDictionary *countyIDDict;

@end

static NSString *kEventCellID = @"kEventCellID";

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];

    NSDictionary *dic = UserDefaultGet([UserDefaultGet(@"userName") stringByAppendingString:@"event"]);
    NSArray *arr = [self eventInfos];
    if (dic && [arr count] > 0) {
        self.events = arr;
    }else {
        NSMutableArray *temp = [NSMutableArray array];
        NSMutableArray *dataTemp = [NSMutableArray array];
        for (NSInteger i=0; i < 5; i++) {
            EventInfo *info = [EventInfo new];
            info.title = [NSString stringWithFormat:@"事件--%u--报道",arc4random_uniform(10)+1];
            info.descript = [NSString stringWithFormat:@"简介--%u--工业和信息化部将于近期发放5G商用牌照 ​​​​。",arc4random_uniform(100)+10];
            info.detailInfo = [NSString stringWithFormat:@"【环球时报-环球网综合报道】记者从工业和信息化部获悉，当前，全球5G正在进入商用部署的关键期。坚持自主创新与开放合作相结合，我国5G产业已建立竞争优势。5G标准是全球产业界共同参与制定的统一国际标准，我国声明的标准必要专利占比超过30%。在技术试验阶段，诺基亚、爱立信、高通、英特尔等多家国外企业已深度参与，在各方共同努力下，我国5G已经具备商用基础。近期，工业和信息化部将发放5G商用牌照，我国将正式进入5G商用元年。我们一如既往地欢迎国内外企业积极参与我国5G网络建设和应用推广，共同分享我国5G发展成果。"];
            NSDate *randomDate = [NSDate dateWithTimeIntervalSinceNow:3600*(arc4random_uniform(24)+0.1)];
            info.endTime = [NSDate dateWithTimeIntervalSinceNow:3600*(arc4random_uniform(24)+0.1)];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
            formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            
            NSString *dateStr = [formatter stringFromDate:randomDate];
            
            NSData *infoData = [NSKeyedArchiver archivedDataWithRootObject:info requiringSecureCoding:YES error:nil];
            [temp addObject:info];
            [dataTemp addObject:infoData];
        }
        self.events = temp.copy;
        UserDefaultSet(dataTemp.copy, @"eventInfos");
        UserDefaultSet(@{UserDefaultGet(@"userName"): dataTemp.copy}, [UserDefaultGet(@"userName") stringByAppendingString:@"event"]);
    }
    
    [self.tableView reloadData];
    [self addMenuTool];
    // Do any additional setup after loading the view.
}

- (void)addMenuTool {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    imgView.layer.cornerRadius = imgView.bounds.size.width/2.0;
    imgView.layer.masksToBounds = YES;
    imgView.image = [UIImage imageNamed:@"timg.jpeg"];
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [imgView addGestureRecognizer:tap];
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20-kTabBarHeight);
        make.right.mas_offset(-20);
        make.width.height.mas_equalTo(60);
    }];
}

- (void)tapClick:(UITapGestureRecognizer *)gesture {
    UIView *view = gesture.view;
    CGPoint point = [gesture locationInView:self.view];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:view.center radius:view.width/2.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    if ([path containsPoint:point]) {
        NSLog(@"123");
        MenuTableViewController *menu = [[MenuTableViewController alloc] init];
        menu.lists = @[@"计算器",@"定时器",@"天气查询"];
        menu.tableView.bounces = NO;
        menu.tableView.scrollEnabled = NO;
        CGFloat width = [@"天气查询" boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} context:nil].size.width;
        menu.preferredContentSize =CGSizeMake(100,menu.lists.count * 44);
        
        menu.modalPresentationStyle =UIModalPresentationPopover;
        
        UIPopoverPresentationController *popVC = menu.popoverPresentationController;
        popVC.delegate =self;
        // 气泡依附于哪个view弹出
        
        popVC.sourceView = view;
        
        // 气泡从哪个位置弹出，是以按钮的上边中心点即（sender.width/2，0）为坐标原点。
        
        popVC.sourceRect =CGRectMake(view.width/2, 0, 0, 0);
        
        // > 箭头的指向（上，下，左，右）
        
        popVC.permittedArrowDirections =UIPopoverArrowDirectionDown;
        
        [self presentViewController:menu animated:YES completion:nil];
        __weak typeof(menu) weakMenu = menu;
        menu.block = ^(NSInteger index) {
            if (index == 0) {
                CalculatorViewController *calculatorVC = [CalculatorViewController new];
                calculatorVC.title = @"简单计算器";
                [self.navigationController pushViewController:calculatorVC animated:YES];
            }else if(index == 1) {
                TimeDownViewController *timeDownVC = [[TimeDownViewController alloc] init];
                timeDownVC.title = @"定时器";
                [self.navigationController pushViewController:timeDownVC animated:YES];
                
            }else {
                [self checkWeather];
            }
            [weakMenu dismissViewControllerAnimated:YES completion:nil];
        };
    }
    
}

- (void)checkWeather {
    
    NSDictionary *countyDict = UserDefaultGet(@"countyList");
    if ([countyDict allValues].count > 0) {
        self.countyIDDict = [NSDictionary dictionaryWithDictionary:countyDict];
    }else {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:path];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"读取文件 = %@", jsonObject);
        NSMutableArray *addressArrM = [NSMutableArray array];
        for (NSInteger i=0; i < [jsonObject[@"CityCode"] count]; i++) {
            NSDictionary *cityCode = jsonObject[@"CityCode"][i];
            for (NSInteger i=0; i < [cityCode[@"cityList"] count]; i++) {
                NSDictionary *cityList = cityCode[@"cityList"][i];
                for (NSInteger i=0; i < [cityList[@"countyList"] count]; i++) {
                    NSDictionary *countyList = cityList[@"countyList"][i];
                    [addressArrM addObject:countyList];
                }
            }
        }
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        for (NSInteger i=0; i < addressArrM.count; i++) {
            dictM[addressArrM[i][@"name"]] = addressArrM[i];
        }
        self.countyIDDict = [NSDictionary dictionaryWithDictionary:dictM.copy];
        UserDefaultSet(dictM.copy, @"countyList");
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //                    NSLog(@"%@",self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"天气查询" message:@"输入城市名" preferredStyle:UIAlertControllerStyleAlert];
        __block NSString *address;
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        }];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            address = alert.textFields[0].text;
            [self requestWeather:alert.textFields[0].text];
            NSLog(@"点击确认");
        }]];
        
        [self presentViewController:alert animated:YES completion:nil];
    });
}

- (void)requestWeather:(NSString *)address {
    if (![[self.countyIDDict allKeys] containsObject:address]) {
        [SVProgressHUD showErrorWithStatus:@"没有查到"];
        return;
    }
    NSString *str = [NSString stringWithFormat:@"http://www.weather.com.cn/data/sk/%@.html",self.countyIDDict[address][@"code"]];
    // 一些特殊字符编码
    NSString *urlString = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 网络请求完成之后就会执行，NSURLSession自动实现多线程
        NSLog(@"%@",[NSThread currentThread]);
        if (data && (error == nil)) {
            // 网络访问成功
            NSLog(@"data=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
            NSDictionary *weatherInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

            NSString *info = [NSString stringWithFormat:@"%@-天气：%@°C，风向：%@，风速：%@",weatherInfo[@"weatherinfo"][@"city"],weatherInfo[@"weatherinfo"][@"temp"],weatherInfo[@"weatherinfo"][@"WD"],weatherInfo[@"weatherinfo"][@"WS"]];
            [SVProgressHUD showInfoWithStatus:info];
        } else {
            // 网络访问失败
            [SVProgressHUD showErrorWithStatus:@"网络访问失败"];
            NSLog(@"error=%@",error);
        }
    }];
    //每一个任务默认都是挂起的，需要调用 resume 方法
    [dataTask resume];
}

- (NSArray *)eventInfos {
    NSMutableArray *temp = [NSMutableArray array];
//    NSArray *infos = UserDefaultGet(@"eventInfos");
    NSArray *infos = UserDefaultGet([UserDefaultGet(@"userName") stringByAppendingString:@"event"])[UserDefaultGet(@"userName")];
//    NSArray *infos = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:data error:nil];
    if (infos.count > 0) {
        for (NSData *data in infos) {
            EventInfo *info = [NSKeyedUnarchiver unarchivedObjectOfClass:[EventInfo class] fromData:data error:nil];
            NSLog(@"%@-%@",[NSDate date],info.endTime);
            NSInteger flag = [self compareOneDay:[NSDate date] withAnotherDay:info.endTime];
            if (info&&flag < 0) {
                [temp addObject:info];
            }
        }
    }
    return  temp.copy;
}

//日期对比
- (int)compareOneDay:(NSDate *)currentDay withAnotherDay:(NSDate *)BaseDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *currentDayStr = [dateFormatter stringFromDate:currentDay];
    NSString *BaseDayStr = [dateFormatter stringFromDate:BaseDay];
    NSDate *dateA = [dateFormatter dateFromString:currentDayStr];
    NSDate *dateB = [dateFormatter dateFromString:BaseDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", currentDay, BaseDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
}

- (void)setupUI {
    SDCycleScrollView *cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, 200) imageNamesGroup:@[@"pic_1.jpg",@"pic_2.jpg",@"pic_3.jpg",@"pic_4.jpg",@"pic_5.jpg"]];
    cycleView.delegate = self;
    cycleView.currentPageDotImage = [UIImage imageNamed:@"fuwu_selected"];
    cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //    cycleView.pageControlRightOffset = 50;
    /*微调和文字对齐*/
    cycleView.pageControlBottomOffset = -5;
    cycleView.titlesGroup = @[@"1",@"2",@"3",@"4",@"5"];
    cycleView.titleLabelBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    cycleView.pageDotImage = [UIImage imageNamed:@"fuwu_normal"];
    [self.view addSubview:cycleView];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cycleView.mas_bottom);
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

- (void)addClick:(UIButton *)sender {
    EventDetailInfoViewController *detailVC = [[EventDetailInfoViewController alloc] init];
    detailVC.title = @"添加事件";
    EventInfo *info = [EventInfo new];
    info.title = @"";
    info.descript = @"";
    info.detailInfo = @"";
    detailVC.info = info;
    detailVC.block = ^{
        NSArray *arr = [self eventInfos];
        if ([arr count] > 0) {
            self.events = arr;
        }
        [self.tableView reloadData];
        [self.tableView setScrollsToTop:YES];
    };
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kEventCellID];
    if (!cell) {
        cell = [[EventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kEventCellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.deleteBlock = ^(UITableViewCell *cell, UIButton *sender) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:[self events]];
        [temp removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *dataTemp = [NSMutableArray array];
        for (NSInteger i=0; i < temp.count; i++) {
            NSData *infoData = [NSKeyedArchiver archivedDataWithRootObject:temp[i] requiringSecureCoding:YES error:nil];
            [dataTemp addObject:infoData];
        }
        self.events = temp.copy;
        UserDefaultSet(dataTemp.copy, @"eventInfos");
        [tableView reloadData];
    };
    cell.info = self.events[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EventDetailInfoViewController *detailVC = [[EventDetailInfoViewController alloc] init];
    detailVC.info = self.events[indexPath.row];
    detailVC.index = indexPath.row;
    detailVC.title = @"事件详情";
    detailVC.block = ^{
        NSArray *arr = [self eventInfos];
        if ([arr count] > 0) {
            self.events = arr;
        }
        [tableView reloadData];
    };
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张图片",index);
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    
    // 此处为不适配(如果选择其他,会自动视频屏幕,上面设置的大小就毫无意义了)
    
    return UIModalPresentationNone;
    
}

@end
