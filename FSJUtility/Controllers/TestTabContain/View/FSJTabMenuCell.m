//
//  FSJTabMenuCell.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/20.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJTabMenuCell.h"

@implementation FSJTabMenuCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _txtLabel = [UILabel fsj_createFont:[UIFont systemFontOfSize:14] color:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.txtLabel];
    
    [self.txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

- (void)configText:(NSString *)text isCenter:(BOOL)isCenter {
    [self.txtLabel setText:text];
    if (isCenter) {
        [self.txtLabel setTextColor:[UIColor whiteColor]];
    }else {
        [self.txtLabel setTextColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
    }
}
@end
