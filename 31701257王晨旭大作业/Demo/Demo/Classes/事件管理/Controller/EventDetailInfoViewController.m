//
//  EventDetailInfoViewController.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "EventDetailInfoViewController.h"
#import "EventInfo.h"
#import "PlaceHolderTextView.h"

@interface EventDetailInfoViewController ()<PlaceHolderTextViewDelegate>
@property (weak, nonatomic) IBOutlet PlaceHolderTextView *titleTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet PlaceHolderTextView *descriptTextView;
@property (weak, nonatomic) IBOutlet PlaceHolderTextView *detailTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end

@implementation EventDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.widthConstraint.constant = kScreenWidth - 20;
    self.titleTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.descriptTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.detailTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    CGFloat titleHeight = [_info.title boundingRectWithSize:CGSizeMake(self.titleTextView.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.titleTextView.font} context:nil].size.height;
    CGFloat descriptHeight = [_info.descript boundingRectWithSize:CGSizeMake(self.descriptTextView.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.descriptTextView.font} context:nil].size.height;
    CGFloat detailHeight = [_info.detailInfo boundingRectWithSize:CGSizeMake(self.detailTextView.width, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.detailTextView.font} context:nil].size.height;
    
    self.titleConstraint.constant = ceil(titleHeight);
    self.descriptConstraint.constant = ceil(descriptHeight);
    self.detailConstraint.constant = ceil(detailHeight);
    
    self.titleTextView.scrollEnabled = NO;
    self.descriptTextView.scrollEnabled = NO;
    self.detailTextView.scrollEnabled = NO;
    
    self.titleTextView.editable = NO;
    self.descriptTextView.editable = NO;
    self.detailTextView.editable = NO;
    
    self.titleTextView.text = _info.title;
    self.descriptTextView.text = _info.descript;
    self.detailTextView.text = _info.detailInfo;
    
    self.titleTextView.placeHolderDelegate = self;
    self.descriptTextView.placeHolderDelegate = self;
    self.detailTextView.placeHolderDelegate = self;
    
    self.titleTextView.placeHolder = @"请输入内容";
    self.descriptTextView.placeHolder = @"请输入内容";
    self.detailTextView.placeHolder = @"请输入内容";
    
    [self.view layoutIfNeeded];
    
    NSLog(@"123 - %@",NSStringFromCGSize(self.scrollView.contentSize));
    
    if ([self.title isEqualToString:@"事件详情"]) {
        [self setupEditNavBarItem];
    }else {
        self.titleTextView.editable = YES;
        self.descriptTextView.editable = YES;
        self.detailTextView.editable = YES;
        [self.titleTextView becomeFirstResponder];
        [self setupAddNavBarItem];
    }
}

- (void)setupEditNavBarItem {
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitle:@"完成" forState:UIControlStateSelected];
    [editBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItem = editItem;
}

- (void)setupAddNavBarItem {
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setTitle:@"完成" forState:UIControlStateNormal];
    [addBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    self.navigationItem.rightBarButtonItem = addItem;
}

//MARK: Click
- (void)editClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (!sender.selected) {
        [self.view resignFirstResponder];
//        NSArray *infos = UserDefaultGet(@"eventInfos");
        NSArray *infos = UserDefaultGet([UserDefaultGet(@"userName") stringByAppendingString:@"event"])[UserDefaultGet(@"userName")];
        NSMutableArray *temp = [NSMutableArray arrayWithArray:infos];
        if (infos.count > 0) {
            EventInfo *info = [NSKeyedUnarchiver unarchivedObjectOfClass:[EventInfo class] fromData:infos[self.index] error:nil];
            info.title = self.titleTextView.text;
            info.descript = self.descriptTextView.text;
            info.detailInfo = self.detailTextView.text;
            temp[self.index] = [NSKeyedArchiver archivedDataWithRootObject:info requiringSecureCoding:YES error:nil];
            UserDefaultSet(temp.copy, @"eventInfos");
            UserDefaultSet(@{UserDefaultGet(@"userName"): temp.copy}, [UserDefaultGet(@"userName") stringByAppendingString:@"event"]);
            !_block ? : _block();
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else {
        [self.titleTextView becomeFirstResponder];
        self.titleTextView.editable = YES;
        self.descriptTextView.editable = YES;
        self.detailTextView.editable = YES;
    }
}

- (void)addClick:(UIButton *)sender {
    [self.view resignFirstResponder];
//    NSArray *infos = UserDefaultGet(@"eventInfos");
    NSArray *infos = UserDefaultGet([UserDefaultGet(@"userName") stringByAppendingString:@"event"])[UserDefaultGet(@"userName")];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:infos];
    EventInfo *info = [NSKeyedUnarchiver unarchivedObjectOfClass:[EventInfo class] fromData:infos[self.index] error:nil];
    if ([NSObject validateIsEmpty:self.titleTextView.text]) {
        [SVProgressHUD showErrorWithStatus:@"标题不能为空"];
        return;}
    if ([NSObject validateIsEmpty:self.descriptTextView.text]) {
        [SVProgressHUD showErrorWithStatus:@"简介不能为空"];
        return;}
    if ([NSObject validateIsEmpty:self.detailTextView.text]) {
        [SVProgressHUD showErrorWithStatus:@"详情不能为空"];
        return;}
    info.title = self.titleTextView.text;
    info.descript = self.descriptTextView.text;
    info.detailInfo = self.detailTextView.text;
   
    info.endTime = [NSDate dateWithTimeIntervalSinceNow:3600*(arc4random_uniform(24)+0.1)];
    [temp insertObject:[NSKeyedArchiver archivedDataWithRootObject:info requiringSecureCoding:YES error:nil] atIndex:0];
//    UserDefaultSet(temp.copy, @"eventInfos");
    UserDefaultSet(@{UserDefaultGet(@"userName"): temp.copy}, [UserDefaultGet(@"userName") stringByAppendingString:@"event"]);
    !_block ? : _block();
    [self.navigationController popViewControllerAnimated:YES];
}

//MARK: UITextViewDelegate
- (void)yjq_textViewDidChange:(PlaceHolderTextView *)textView {
    [self updateTextViewFrame:textView];
}

- (void)yjq_textViewDidEndEditing:(PlaceHolderTextView *)textView {
    if (textView == self.titleTextView) {
        
        self.titleTextView.text = textView.text;
        
    }else if (textView == self.descriptTextView) {
        
        self.descriptTextView.text = textView.text;
        
    }else {
        
        self.detailTextView.text = textView.text;
    }
}

- (void)updateTextViewFrame:(UITextView *)textView {
    //获得textView的初始尺寸
    CGFloat width = CGRectGetWidth(textView.frame);
    CGFloat height = CGRectGetHeight(textView.frame);
    CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmax(width, newSize.width), fmax(height, newSize.height));
    textView.frame= newFrame;
    NSLog(@"123 - %@",NSStringFromCGRect(textView.frame));
    if (textView == self.titleTextView) {
//        self.titleConstraint.constant = fmax(height, newSize.height);
        self.titleConstraint.constant = newSize.height;
    }else if (textView == self.descriptTextView) {
//        self.descriptConstraint.constant = fmax(height, newSize.height);
        self.descriptConstraint.constant = newSize.height;
    }else {
//        self.detailConstraint.constant = fmax(height, newSize.height);
        self.detailConstraint.constant = newSize.height;
    }
    [self.view layoutIfNeeded];
}

//-(void)textViewDidChange:(UITextView *)textView{
//    //获得textView的初始尺寸
//    CGFloat width = CGRectGetWidth(textView.frame);
//    CGFloat height = CGRectGetHeight(textView.frame);
//    CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
//    CGRect newFrame = textView.frame;
//    newFrame.size = CGSizeMake(fmax(width, newSize.width), fmax(height, newSize.height));
//    textView.frame= newFrame;
//    if (textView == self.titleTextView) {
////        self.titleConstraint.constant = fmax(height, newSize.height);
//        self.titleConstraint.constant = newSize.height;
//    }else if (textView == self.descriptTextView) {
//        self.descriptConstraint.constant = fmax(height, newSize.height);
//    }else {
//        self.detailConstraint.constant = fmax(height, newSize.height);
//    }
//    NSLog(@"123 - %@",NSStringFromCGRect(textView.frame));
//    [self.view layoutIfNeeded];
//    self.scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetMaxY(self.titleTextView.frame)+5);
//    NSLog(@"456 - %@",NSStringFromCGSize(self.scrollView.contentSize));
//
////    NSMutableArray *temp = [NSMutableArray array];
//
//
////    static CGFloat maxHeight =60.0f;
////    CGRect frame = textView.frame;
////    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
////    CGSize size = [textView sizeThatFits:constraintSize];
////    if (size.height<=frame.size.height) {
////        size.height=frame.size.height;
////    }else{
////        if (size.height >= maxHeight)
////        {
////            size.height = maxHeight;
////            textView.scrollEnabled = YES;   // 允许滚动
////        }
////        else
////        {
////            textView.scrollEnabled = NO;    // 不允许滚动
////        }
////    }
////    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
//}

@end
