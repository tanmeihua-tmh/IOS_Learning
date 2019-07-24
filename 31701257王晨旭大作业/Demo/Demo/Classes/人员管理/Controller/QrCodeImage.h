//
//  QrCodeImage.h
//  Demo
//
//  Created by 王晨旭 on 2019/6/5.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
NS_ASSUME_NONNULL_BEGIN

@interface QrCodeImage : UIView
/**
 *  生成带logo的二维码
 *  二维码和logo都是正方形的
 *  @param urlString     二维码中的链接
 *  @param QRCodeCGRect  二维码的CGRect
 *  @param logoImage     二维码中的logo
 *  @param logoImageSize logo的大小
 *  @param cornerRadius  logo的圆角值大小
 *
 *  @return 生成的二维码
 */
+ (QrCodeImage *)creatQRCodeWithURLString:(NSString *)urlString superView:(UIView *)superView logoImage:(UIImage *)logoImage logoImageSize:(CGSize)logoImageSize logoImageWithCornerRadius:(CGFloat)cornerRadius;

/**
 *  读取图片中的二维码
 *
 *  @param image 图片
 *
 *  @return 图片中的二维码数据集合 CIQRCodeFeature对象
 */
+ (NSArray *)readQRCodeFromImage:(UIImage *)image;

/**
 *  截图
 *
 *  @param view 需要截取的视图
 *
 *  @return 截图 图片
 */
+ (UIImage *)screenShotFormView:(UIView *)view;
- (CIImage *)creatQRcodeWithUrlstring:(NSString *)urlString;
@end

NS_ASSUME_NONNULL_END
