//
//  TimeDownViewController.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "TimeDownViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface TimeDownViewController ()
@property (weak, nonatomic) IBOutlet UITextField *hourTF;
@property (weak, nonatomic) IBOutlet UITextField *minuteTF;
@property (weak, nonatomic) IBOutlet UITextField *secondTF;
@property (nonatomic, strong) dispatch_source_t timer;
@property (weak, nonatomic) IBOutlet UIButton *addHourBtn;
@property (weak, nonatomic) IBOutlet UIButton *addMinuteBtn;
@property (weak, nonatomic) IBOutlet UIButton *addSecondBtn;
@property (weak, nonatomic) IBOutlet UIButton *minusHourBtn;
@property (weak, nonatomic) IBOutlet UIButton *minusMinuteBtn;
@property (weak, nonatomic) IBOutlet UIButton *minusSecondBtn;

@end

@implementation TimeDownViewController {
    NSInteger _hourCount;
    NSInteger _minuteCount;
    NSInteger _secondCount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)add:(UIButton *)sender {
    if (sender.tag == 1) {
        _hourCount++;
        _hourCount = _hourCount > 0 ? (_hourCount > 24 ? 0 : _hourCount) : 24;
        self.hourTF.text = [NSString stringWithFormat:@"%02ld",_hourCount];
    }else if (sender.tag == 2) {
        _minuteCount++;
        _minuteCount = _minuteCount > 0 ? (_minuteCount > 59 ? 0 : _minuteCount) : 59;
        self.minuteTF.text = [NSString stringWithFormat:@"%02ld",_minuteCount];
    }else {
        _secondCount++;
        _secondCount = _secondCount > 0 ? (_secondCount > 59 ? 0 : _secondCount) : 59;
        self.secondTF.text = [NSString stringWithFormat:@"%02ld",_secondCount];
    }
}

- (IBAction)minus:(UIButton *)sender {
    if (sender.tag == 4) {
        _hourCount--;
        _hourCount = _hourCount >= 0 ? (_hourCount > 24 ? 0 : _hourCount) : 24;
        self.hourTF.text = [NSString stringWithFormat:@"%02ld",_hourCount];
    }else if (sender.tag == 5) {
        _minuteCount--;
        _minuteCount = _minuteCount >= 0 ? (_minuteCount > 59 ? 0 : _minuteCount) : 59;
        self.minuteTF.text = [NSString stringWithFormat:@"%02ld",_minuteCount];
    }else {
        _secondCount--;
        _secondCount = _secondCount >= 0 ? (_secondCount > 59 ? 0 : _secondCount) : 59;
        self.secondTF.text = [NSString stringWithFormat:@"%02ld",_secondCount];
    }
}

- (IBAction)startTimeDown:(UIButton *)sender {
    __block NSInteger times = _hourCount * 60 * 60 + _minuteCount * 60 + _secondCount;
    if (times <= 0) {
        return;
    }
    
    [self enabledWith:NO];
    
    if (self.timer) {
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    self.timer = timer;
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW,1.0 * NSEC_PER_SEC);//1.0秒之后开始执行
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);//每隔2.0秒执行一次
    dispatch_source_set_timer(timer, start, interval, 0.1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        times--;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger hour = times/3600;
            NSInteger minute = (times/60)%60;
            NSInteger second = times%60;
            self.hourTF.text = [NSString stringWithFormat:@"%02ld",hour];
            self.minuteTF.text = [NSString stringWithFormat:@"%02ld",minute];
            self.secondTF.text = [NSString stringWithFormat:@"%02ld",second];
            self->_hourCount = hour;
            self->_minuteCount = minute;
            self->_secondCount = second;
        });
        if (times <= 0) {
            SystemSoundID sound = 0;
            NSString *path = @"/System/Library/Audio/UISounds/sms-received2.caf";
            //[[NSBundle bundleWithIdentifier:@"com.apple.UIKit" ]pathForResource:soundName ofType:soundType];//得到苹果框架资源UIKit.framework ，从中取出所要播放的系统声音的路径
            //[[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];  获取自定义的声音
            if (path) {
                OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
                if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
                    sound = 0;
                }
            }
            //            kSystemSoundID_Vibrate
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            AudioServicesPlaySystemSoundWithCompletion(sound, ^{
                //声音播放完毕，并震动完成后调用的代码块
                NSLog(@"456");
            });
            [self openEnabled];
            dispatch_source_cancel(timer);
        }
    });
    dispatch_resume(timer);
}
- (IBAction)pauseTimer:(UIButton *)sender {
    [self openEnabled];
}
- (IBAction)endTimer:(UIButton *)sender {
    self.hourTF.text = @"00";
    self.minuteTF.text = @"00";
    self.secondTF.text = @"00";
    _hourCount = 0;
    _minuteCount = 0;
    _secondCount = 0;
    if (self.timer) {
        [self openEnabled];
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

- (void)openEnabled {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self enabledWith:YES];
        if(self.timer){
            dispatch_suspend(self.timer);
        }
    });
}

- (void)enabledWith:(BOOL)enabled {
    self.addHourBtn.enabled = enabled;
    self.addMinuteBtn.enabled = enabled;
    self.addSecondBtn.enabled = enabled;
    self.minusHourBtn.enabled = enabled;
    self.minusMinuteBtn.enabled = enabled;
    self.minusSecondBtn.enabled = enabled;
    self.hourTF.enabled = enabled;
    self.minuteTF.enabled = enabled;
    self.secondTF.enabled = enabled;
}

- (void)dealloc
{
    NSLog(@"timerVC 释放");
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
