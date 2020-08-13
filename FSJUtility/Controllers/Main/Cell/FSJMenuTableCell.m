//
//  FSJMenuTableCell.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/12.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJMenuTableCell.h"
#import "FSJMenuModel.h"

@implementation FSJMenuTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        [self layoutUI];
    }
    return self;
}

- (void)setup {
    [self.contentView addSubview:self.titleLabel];
}

- (void)layoutUI {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self).inset(15);
        make.top.bottom.mas_equalTo(self);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel fsj_createFont:[UIFont systemFontOfSize:15] color:[UIColor blackColor]];
    }
    return _titleLabel;
}

#pragma mark - 重写方法
- (void)cellForRowAtIndexPath:(NSIndexPath *)indexPath targetView:(UIView *)targetView model:(id)model eventTransmissionBlock:(CHGEventTransmissionBlock)eventTransmissionBlock {
    [super cellForRowAtIndexPath:indexPath targetView:targetView model:model eventTransmissionBlock:eventTransmissionBlock];
    
    FSJMenuModel *tmpModel = model;
    [self.titleLabel setText:tmpModel.text];
    [self setBackgroundColor:[UIColor clearColor]];
}

@end
