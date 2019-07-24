//
//  UIView+Extension.m
//  原创新闻
//
//  Created by 王烁 on 15/10/23.
//  Copyright © 2015年 王烁. All rights reserved.
//

#import "UIView+Extension.h"
#define SHOW_VIEW @"show"
#define HIDDEN_VIEW @"hidden"
// 基准屏幕宽度
#define kRefereWidth 375.0
// 以屏幕宽度为固定比例关系，来计算对应的值。假设：基准屏幕宽度375，floatV=10；当前屏幕宽度为750时，那么返回的值为20
#define AdaptW(floatValue) (floatValue*[[UIScreen mainScreen] bounds].size.width/kRefereWidth)

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame=self.frame;
    frame.size=size;
    self.frame=frame;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame=self.frame;
    frame.origin=origin;
    self.frame=frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)removeAllSubviews {
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}


- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


+ (void)ShowView:(UIView *)view To:(CGRect)frame During:(float)time delegate:(id)delegate
{
    [UIView beginAnimations:SHOW_VIEW context:(void *)view];
    [UIView setAnimationDuration:time];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    if(delegate !=nil &&[delegate respondsToSelector:@selector(onAnimationComplete:finished:context:)]){
        [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
        [UIView setAnimationDelegate:delegate];
    }
    view.hidden = NO;
    view.layer.opacity = 1;
    view.frame = frame;
    [UIView commitAnimations];
}

+ (void)HiddenView:(UIView *)view To:(CGRect)frame During:(float)time delegate:(id)delegate
{
    [UIView beginAnimations:HIDDEN_VIEW context:(void *)view];
    [UIView setAnimationDuration:time];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    if(delegate !=nil &&[delegate respondsToSelector:@selector(onAnimationComplete:finished:context:)]){
        [UIView setAnimationDidStopSelector:@selector(onAnimationComplete:finished:context:)];
        [UIView setAnimationDelegate:delegate];
    }
    view.frame = frame;
    view.layer.opacity = 0.0;
    [UIView commitAnimations];
}

- (void)onAnimationComplete:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString: SHOW_VIEW]) {
        
    } else if ([animationID isEqualToString:HIDDEN_VIEW]) {
        
    }
}

- (void)adaptScreenWidthWithType:(BSAdaptScreenWidthType)type
                     exceptViews:(NSArray<Class> *)exceptViews {
    if (type == AdaptScreenWidthTypeNone)  return;
    if (![self isExceptViewClassWithClassArray:exceptViews]) {
        
        // 是否要对约束进行等比例
        BOOL adaptConstraint = ((type & BSAdaptScreenWidthTypeConstraint) || type == BSAdaptScreenWidthTypeAll);
        
        // 是否对字体大小进行等比例
        BOOL adaptFontSize = ((type & BSAdaptScreenWidthTypeFontSize) || type == BSAdaptScreenWidthTypeAll);
        
        // 是否对圆角大小进行等比例
        BOOL adaptCornerRadius = ((type & BSAdaptScreenWidthTypeCornerRadius) || type == BSAdaptScreenWidthTypeAll);
        
        // 约束
        if (adaptConstraint) {
            [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull subConstraint, NSUInteger idx, BOOL * _Nonnull stop) {
                subConstraint.constant = AdaptW(subConstraint.constant);
            }];
        }
        
        // 字体大小
        if (adaptFontSize) {
            
            if ([self isKindOfClass:[UILabel class]] && ![self isKindOfClass:NSClassFromString(@"UIButtonLabel")]) {
                UILabel *labelSelf = (UILabel *)self;
                labelSelf.font = [UIFont systemFontOfSize:AdaptW(labelSelf.font.pointSize)];
            }
            else if ([self isKindOfClass:[UITextField class]]) {
                UITextField *textFieldSelf = (UITextField *)self;
                textFieldSelf.font = [UIFont systemFontOfSize:AdaptW(textFieldSelf.font.pointSize)];
            }
            else  if ([self isKindOfClass:[UIButton class]]) {
                UIButton *buttonSelf = (UIButton *)self;
                buttonSelf.titleLabel.font = [UIFont systemFontOfSize:AdaptW(buttonSelf.titleLabel.font.pointSize)];
            }
            else  if ([self isKindOfClass:[UITextView class]]) {
                UITextView *textViewSelf = (UITextView *)self;
                textViewSelf.font = [UIFont systemFontOfSize:AdaptW(textViewSelf.font.pointSize)];
            }
        }
        
        // 圆角
        if (adaptCornerRadius) {
            if (self.layer.cornerRadius) {
                self.layer.cornerRadius = AdaptW(self.layer.cornerRadius);
            }
        }
        
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
            // 继续对子view操作
            [subView adaptScreenWidthWithType:type exceptViews:exceptViews];
        }];
    }
}

// 当前view对象是否是例外的视图
- (BOOL)isExceptViewClassWithClassArray:(NSArray<Class> *)classArray {
    __block BOOL isExcept = NO;
    [classArray enumerateObjectsUsingBlock:^(Class  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self isKindOfClass:obj]) {
            isExcept = YES;
            *stop = YES;
        }
    }];
    return isExcept;
}


@end
