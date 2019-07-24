//
//  NewCell.h
//  cell
//
//  Created by 王晨旭 on 2019/5/5.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *comment;

@end

NS_ASSUME_NONNULL_END
