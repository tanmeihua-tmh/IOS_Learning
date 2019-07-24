//
//  ViewController.m
//  定位
//
//  Created by 王晨旭 on 2019/5/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *jd;
@property (weak, nonatomic) IBOutlet UILabel *wd;
@property (nonatomic, strong) CLLocationManager *mgr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%d", [CLLocationManager locationServicesEnabled]);
    
    if ([self.mgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.mgr requestAlwaysAuthorization];
    }
    
    [self.mgr startUpdatingLocation];
    CLLocation *location =_mgr.location;
    CLLocationCoordinate2D coordinate = location.coordinate;
    self.jd.text=[NSString stringWithFormat:@"%f", coordinate.latitude];
    self.wd.text=[NSString stringWithFormat:@"%f", coordinate.longitude];
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 取出用户的位置信息
    CLLocation *location = [locations lastObject];
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
   
    // 当定位到用户信息之后,马上停止定位(否则非常耗电)
    [manager stopUpdatingLocation];
}
#pragma mark - 懒加载
- (CLLocationManager *)mgr
{
    if (_mgr == nil) {
        // 创建CLLocationManager对象
        self.mgr = [[CLLocationManager alloc] init];
        
        // 设置移动多少米,更新一次用户的位置
        self.mgr.distanceFilter = 50;
        
        // 设置定位精度
        self.mgr.desiredAccuracy = kCLLocationAccuracyBest;
        
        // 设置CLLocationManager的代理,来获取用户的位置
        self.mgr.delegate = self;
    }
    return _mgr;
}

@end
