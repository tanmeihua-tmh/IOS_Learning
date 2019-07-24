//
//  EventTableViewCell.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/27.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "EventTableViewCell.h"

@interface EventTableViewCell ()

@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *descriptLB;

@end

@implementation EventTableViewCell

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
        make.top.left.mas_offset(8);
        make.right.mas_offset(-8);
    }];
    
    [self.contentView addSubview:self.descriptLB];
    [self.descriptLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLB.mas_bottom).offset(10);
        make.left.mas_offset(12);
        make.bottom.right.mas_offset(-8);
    }];
    
    [self configurationTableViewCellType:SCTEditCollectionCellTypeWithDelete];
}

- (void)setInfo:(EventInfo *)info {
    _info = info;
    self.titleLB.text = info.title;
    self.descriptLB.text = info.descript;
}

#pragma mark - Lazy

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.text = @"事件title";
        _titleLB.textAlignment = NSTextAlignmentLeft;
        _titleLB.font = [UIFont systemFontOfSize:18];
        _titleLB.numberOfLines = 0;
    }
    return _titleLB;
}

- (UILabel *)descriptLB {
    if (!_descriptLB) {
        _descriptLB = [[UILabel alloc] init];
        _descriptLB.text = @"测试。。。";
        _descriptLB.textAlignment = NSTextAlignmentLeft;
        _descriptLB.font = [UIFont systemFontOfSize:14];
        _descriptLB.tintColor = [UIColor lightGrayColor];
        _descriptLB.numberOfLines = 0;
    }
    return _descriptLB;
}

@end
