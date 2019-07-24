//
//  SetupTableViewCell.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/28.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "SetupTableViewCell.h"

@interface SetupTableViewCell ()

//@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *infoLB;

@end

@implementation SetupTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.titleLB];
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(8);
        make.right.mas_equalTo(-8).priority(500);
        make.bottom.mas_equalTo(-8);
    }];
    
    [self.contentView addSubview:self.infoLB];
    [self.infoLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLB);
        make.right.mas_equalTo(-8);
        make.left.mas_equalTo(self.titleLB.mas_right).offset(8);
    }];
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:16];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentLeft;
        _titleLB = label;
    }
    return _titleLB;
}

- (UILabel *)infoLB {
    if (!_infoLB) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentRight;
        _infoLB = label;
    }
    return _infoLB;
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
