//
//  SCTEditTableViewCell.h
//  SCTeacher
//
//  Created by yjq on 2018/8/23.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SCTEditTableViewCellType) {
    SCTEditCollectionCellTypeWithNone = 0,
    SCTEditCollectionCellTypeWithDelete,
};

@interface SCTEditTableViewCell : UITableViewCell

-(void)configurationTableViewCellType:(SCTEditTableViewCellType)type;
-(void)hiddenButtonsWithAnimation;

@property (nonatomic, copy) void (^deleteBlock)(UITableViewCell *cell ,UIButton *sender);
@end
