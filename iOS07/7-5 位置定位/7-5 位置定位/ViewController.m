//
//  ViewController.m
//  7-5 位置定位
//
//  Created by wujz on 16/6/11.
//  Copyright © 2016年 zucc. All rights reserved.
//


#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSLog(@"%d", [CLLocationManager locationServicesEnabled]);

    // 1.定位
    if ([self.mgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.mgr requestAlwaysAuthorization];
    }
    [self.mgr startUpdatingLocation];

    // 2.计算两个Location之间的位置
//    [self countDistance];
}

/**
 *  定位到用户位置时会调用该方法(该方法会频繁调用)
 *
 *  @param locations 里面放着CLLocation对象(用户的位置信息)
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 取出用户的位置信息
    CLLocation *location = [locations lastObject];

    CLLocationCoordinate2D coordinate = location.coordinate;

    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);

    // 当定位到用户信息之后,马上停止定位(否则非常耗电)
    [manager stopUpdatingLocation];
}

/**
 *  计算两个Location之间的距离
 */
- (void)countDistance
{
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:40.23 longitude:116.39];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:30.23 longitude:120.23];
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    NSLog(@"两个位置之间的距离：%.2f", distance);
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
