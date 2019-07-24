//
//  NSObject+Regex.h
//  Demo
//
//  Created by 王晨旭 on 2019/5/30.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Regex)

/**
 *  验证邮箱
 *
 *  @param email 邮箱
 *
 *  @return YES/NO
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 *  验证手机号
 *
 *  @param mobile 手机号
 *
 *  @return YES/NO
 */
+ (BOOL)validateMobile:(NSString *)mobile;

/**
 *  验证用户名
 *
 *  @param name 用户名
 *
 *  @return YES/NO
 */
+ (BOOL)validateUserName:(NSString *)name;

/**
 *  验证密码
 *
 *  @param passWord 密码
 *
 *  @return YES/NO
 */
+ (BOOL)validatePassword:(NSString *)passWord;

/**
 *  验证昵称
 *
 *  @param nickname 昵称
 *
 *  @return YES/NO
 */
+ (BOOL)validateNickname:(NSString *)nickname;

/**
 *  验证字符串是否为空值
 *
 *  @param targetString 目标字符串
 *
 *  @return YES/NO
 */
+ (BOOL)validateIsEmpty:(NSString *)targetString;

//验证QQ号
+ (BOOL)validateIsValidQQ:(NSString *)targetString;

//验证微信账号
+ (BOOL)validateIsValidWeChat:(NSString *)targetString;

//验证是否只是数字
+ (BOOL)validateIsOnlyNumber:(NSString *)targetString;

@end

NS_ASSUME_NONNULL_END
