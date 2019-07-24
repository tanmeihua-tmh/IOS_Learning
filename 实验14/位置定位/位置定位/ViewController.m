//
//  ViewController.m
//  位置定位
//
//  Created by 王晨旭 on 2019/5/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController () <MKMapViewDelegate,CLLocationManagerDelegate,MKAnnotation>
@property (weak, nonatomic) IBOutlet MKMapView *mapKit;

@property (nonatomic, strong) UISegmentedControl *segment;
- (void)addAnnotation:(id <MKAnnotation>)annotation;

// 这个属性主要用来请求权限
@property (strong, nonatomic) CLLocationManager *mgr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_mapKit setMapType:MKMapTypeHybrid];
    self.mapKit.userTrackingMode = MKUserTrackingModeFollow;
    if ([self.mgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.mgr requestAlwaysAuthorization];
    }
}


#pragma mark - 懒加载
- (CLLocationManager *)mgr {
    if (_mgr == nil) {
        _mgr = [[CLLocationManager alloc] init];
    }
    return _mgr;
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    // 反地理编码；根据经纬度查找地名
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count == 0 || error) {
            NSLog(@"找不到该位置");
            return;
        }
        
        // 当前地标
        CLPlacemark *pm = [placemarks firstObject];
        
        // 区域名称
        userLocation.title = pm.locality;
        // 详细名称
        userLocation.subtitle = pm.name;
    }];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    for(CLLocation *location in locations){
        NSLog(@"---------%@-------",location);
    }
    CLLocation *currLocation=[locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];//反向解析，根据及纬度反向解析出地址
    CLLocation *location = [locations objectAtIndex:0];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        for(CLPlacemark *place in placemarks)
        {
            //取出当前位置的坐标
            NSLog(@"latitude : %f,longitude: %f",currLocation.coordinate.latitude,currLocation.coordinate.longitude);
            NSString *latStr = [NSString stringWithFormat:@"%f",currLocation.coordinate.latitude];
            NSString *lngStr = [NSString stringWithFormat:@"%f",currLocation.coordinate.longitude];
            NSDictionary *dict = [place addressDictionary];
            NSMutableDictionary *resultDic = [[NSMutableDictionary alloc] init];
            [resultDic setObject:dict[@"SubLocality"] forKey:@"xian"];
            [resultDic setObject:dict[@"City"] forKey:@"shi"];
            [resultDic setObject:latStr forKey:@"wei"];
            [resultDic setObject:lngStr forKey:@"jing"];
            [resultDic setObject:dict[@"State"] forKey:@"sheng"];
            [resultDic setObject:dict[@"Name"] forKey:@"all"];
            NSLog(@"------addressDictionary-%@------",dict);
            [[NSUserDefaults standardUserDefaults] setObject:dict[@"SubLocality"] forKey:@"XianUser"];
            [[NSUserDefaults standardUserDefaults] setObject:resultDic forKey:@"LocationInfo"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
}

    
  

@end


