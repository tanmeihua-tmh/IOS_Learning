//
//  SCTEditTableViewCell.m
//  SCTeacher
//
//  Created by yjq on 2018/8/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SCTEditTableViewCell.h"
#import <objc/runtime.h>

#define kButtonWidth 70

@interface SCTEditTableViewCell ()<UIGestureRecognizerDelegate>
{
    CGPoint origin;
    BOOL isLeft;
    UIButton *_btn;
}

@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@end

@implementation SCTEditTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    self.contentView.backgroundColor= [UIColor whiteColor];
    _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureDidPan:)];
    _pan.delegate = self;
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    _tap.delegate = self;
    [self.contentView addGestureRecognizer:_tap];
}
-(void)panGestureDidPan:(UIPanGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            origin = [gesture translationInView:self];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [gesture translationInView:self];
            isLeft = (translation.x - origin.x < 0);
        }
        case UIGestureRecognizerStateEnded:
        {
            if (isLeft) {
                [self showButtonsWithAnimation];
            }else {
                [self hiddenButtonsWithAnimation];
            }
        }
            break;
        default:
            break;
    }
}
-(void)tapGesture:(UITapGestureRecognizer *)gesture {
    if (self.contentView.x == -kButtonWidth) {
        [self hiddenButtonsWithAnimation];
    }
}
-(void)configurationTableViewCellType:(SCTEditTableViewCellType)type {
    [self.contentView addGestureRecognizer:_pan];
    if (type == SCTEditCollectionCellTypeWithNone) {
        [self.contentView removeGestureRecognizer:_pan];
    }
    if (type == SCTEditCollectionCellTypeWithDelete) {
        if (!_btn) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(kScreenWidth - kButtonWidth, 0, kButtonWidth, self.height);
            NSLog(@"%@,%lf",NSStringFromCGRect(btn.frame),kScreenWidth);
            [btn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"删除" forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [btn setBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.7]];
            [self addSubview:btn];
            [self sendSubviewToBack:btn];
            _btn = btn;
        } 
    }
}

-(void)deleteClick:(UIButton *)sender {
    if (_deleteBlock) {
        [self hiddenButtonsWithAnimation];
        self.deleteBlock(self,sender);
    }
}

-(void)hiddenButtonsWithAnimation {
    if (self.contentView.x != 0) {
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.x = 0;
        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)showButtonsWithAnimation {
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.x = -kButtonWidth;
    } completion:^(BOOL finished) {
        
    }];
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    SCTEditTableViewCell *currentCell = objc_getAssociatedObject(self.superview, @"currentCell");
    if (gestureRecognizer == _pan && [gestureRecognizer.view isKindOfClass:[UIView class]]) {
        CGPoint translation = [_pan translationInView:self];
        objc_setAssociatedObject(self.superview, @"currentCell", self, OBJC_ASSOCIATION_ASSIGN);
        //判断滑动
        if(fabs(translation.y) > fabs(translation.x)) {
            //表示竖着滑动
            //由于tableView有边距，触摸到tableView边距时，这个方法不会生效，所以滑动的时候在外部判断隐藏
            //[currentCell hiddenButtonsWithAnimation];//关闭当前左滑的cell
            return NO;//禁止cell的竖向滑动，使其响应collectionview的上下滚动
        }
        if (currentCell != nil && currentCell != self) {
            [currentCell hiddenButtonsWithAnimation];
        }
        //表示横着滑动
        return YES;
    }else if (gestureRecognizer == _tap && [gestureRecognizer.view isKindOfClass:[UIView class]]) {
        //判断如果当前没有滑动的cell，则关闭cell内部点击事件，响应外部didSelectItemAtIndexPath事件
        //x坐标不为0时，表示当前cell处于左滑状态
        if (currentCell.contentView.x != 0) {
            //关闭当前左滑的cell
            [currentCell hiddenButtonsWithAnimation];
            return YES;
        }else {
            return NO;
        }
    }else if ([gestureRecognizer.view isKindOfClass:[UITableView class]]){
        return YES;
    }
    return NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _btn.height = self.height;
    NSLog(@"---%@",NSStringFromCGRect(self.frame));
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
