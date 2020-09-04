//
//  FSJTestTaskCell.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/3.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJTestTaskCell.h"
#import "FSJTestDelayTask.h"

@implementation FSJTestTaskCell
- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellForRowAtIndexPath:(NSIndexPath *)indexPath targetView:(UIView *)targetView model:(id)model eventTransmissionBlock:(CHGEventTransmissionBlock)eventTransmissionBlock {
    [super cellForRowAtIndexPath:indexPath targetView:targetView model:model eventTransmissionBlock:eventTransmissionBlock];
    FSJTestDelayTask *tmpModel = model;
    self.textLabel.text = tmpModel.title;
}

- (void)cellDidDisappear {
    [super cellDidDisappear];
    self.model = nil;
}

@end
