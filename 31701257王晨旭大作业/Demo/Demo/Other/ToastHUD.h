//
//  ToastHUD.h
//  Demo
//
//  Created by 王晨旭 on 2019/5/31.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "SVProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ToastHUDDismissCompletion)(void);

@interface ToastHUD : SVProgressHUD
+(void)showToast:(NSString*)msg;
+(void)showToast:(NSString*)msg andDuration:(CGFloat)duration;
+(void)showToast:(NSString*)msg completion:(nullable ToastHUDDismissCompletion)completion;
+(void)showToast:(NSString*)msg andDuration:(CGFloat)duration completion:(nullable ToastHUDDismissCompletion)completion;
@end

NS_ASSUME_NONNULL_END
