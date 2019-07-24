//
//  UIView+Extension.h
//  原创新闻
//
//  Created by 王烁 on 15/10/23.
//  Copyright © 2015年 王烁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BSAdaptScreenWidthType) {
    AdaptScreenWidthTypeNone = 0,
    BSAdaptScreenWidthTypeConstraint = 1<<0, /**< 对约束的constant等比例 */
    BSAdaptScreenWidthTypeFontSize = 1<<1, /**< 对字体等比例 */
    BSAdaptScreenWidthTypeCornerRadius = 1<<2, /**< 对圆角等比例 */
    BSAdaptScreenWidthTypeAll = 1<<3, /**< 对现有支持的属性等比例 */
};

@interface UIView (Extension)
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;

- (void)removeAllSubviews;

- (UIViewController *)viewController;

+(void)ShowView:(UIView *)view To:(CGRect)frame During:(float)time delegate:(id)delegate;

+(void)HiddenView:(UIView *)view To:(CGRect)frame During:(float)time delegate:(id)delegate;

/**
 遍历当前view对象的subviews和constraints，对目标进行等比例换算
 
 @param type 想要和基准屏幕等比例换算的属性类型
 @param exceptViews 需要对哪些类进行例外
 */
- (void)adaptScreenWidthWithType:(BSAdaptScreenWidthType)type
                     exceptViews:(NSArray<Class> *)exceptViews;

@end
