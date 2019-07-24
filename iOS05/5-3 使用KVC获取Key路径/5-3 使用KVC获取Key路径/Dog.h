//
//  Dog.h
//  5-3 使用KVC获取Key路径
//
//  Created by wujz on 16/5/28.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DogFurColorWhite = 0, // 白色
    DogFurColorBrown,     // 棕色
    DogFurColorBlack      // 黑色
}DogFurColor; //枚举名称

@interface Dog : NSObject
// 表示狗的皮毛颜色
@property (nonatomic, assign) DogFurColor color;
@end
