//
//  FSJMenuCollectionCell.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/4.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJMenuCollectionCell.h"
#import "FSJMenuModel.h"

@implementation FSJMenuCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self.contentView setBackgroundColor:[UIColor fsj_randomColor]];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel fsj_createFont:[UIFont systemFontOfSize:15] color:[UIColor blackColor] alignment:NSTextAlignmentCenter];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (void)cellForRowAtIndexPath:(NSIndexPath *)indexPath targetView:(UIView *)targetView model:(id)model eventTransmissionBlock:(CHGEventTransmissionBlock)eventTransmissionBlock{
    [super cellForRowAtIndexPath:indexPath targetView:targetView model:model eventTransmissionBlock:eventTransmissionBlock];
    FSJMenuModel *tmpModel = model;
    [self.titleLabel setText:tmpModel.text];
}
@end
