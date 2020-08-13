//
//  FSJAlertSheetView.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/13.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJAlertSheetView.h"
#import "UIApplication+FSJUtility.h"

@interface FSJAlertSheetView ()

@property (nonatomic, weak) NSString *title;
@property (nonatomic, weak) NSString *message;
@property (nonatomic, weak) NSString *cancelButtonTitle;
@property (nonatomic, strong) NSArray *otherArray;
@property (nonatomic, assign) UIAlertControllerStyle style;
@property (nonatomic, strong) NSMutableDictionary *otherDictionary;

@end

@implementation FSJAlertSheetView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    self = [super init];
    if ( self ) {
        id eachObject;
        va_list
        argumentList;
        NSMutableArray *array = [NSMutableArray new];
        if (otherButtonTitles)
        {
            [array addObject:otherButtonTitles];
            va_start(argumentList, otherButtonTitles);
            while ((eachObject =
                    va_arg(argumentList, id)))
                [array addObject: eachObject];
            va_end(argumentList);
        }
        _title = title;
        _message = message;
        _cancelButtonTitle = cancelButtonTitle;
        _otherArray = array;
        _style = style;
    }
    return self;
}

- (void)addTitle:(NSString *)title {
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self.otherArray];
    [array addObject:title];
    _otherArray = array;
}

- (void)show:(void (^)(NSInteger index))block {
    UIViewController *vc = self.vc?self.vc:[[UIApplication sharedApplication] fsj_activityViewController];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self.title message:self.message preferredStyle:self.style];
    if (self.cancelButtonTitle && self.cancelButtonTitle.length > 0) {
        [alertController addAction:[UIAlertAction actionWithTitle:self.cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (block) {
                block(0);
            }
        }]];
    }
    
    for (NSInteger i = 0; i < self.otherArray.count; i++) {
        NSString *str = self.otherArray[i];
        UIAlertActionStyle actionStyle = UIAlertActionStyleDefault;
        if (self.otherDictionary) {
            NSNumber *num = [self.otherDictionary objectForKey:str];
            if (num) {
                actionStyle = num.integerValue;
            }
        }
        [alertController addAction:[UIAlertAction actionWithTitle:str style:actionStyle handler:^(UIAlertAction * _Nonnull action) {
            if (block) {
                block(i+1);
            }
        }]];
    }
    
    [vc presentViewController:alertController animated:YES completion:^{}];
}

- (void)setActionStyle:(UIAlertActionStyle)style index:(NSInteger)index {
    if (!_otherDictionary) {
        _otherDictionary = [[NSMutableDictionary alloc] init];
    }
    if (index < self.otherArray.count) {
        NSString *str = self.otherArray[index];
        [self.otherDictionary setObject:@(style) forKey:str];
    }
}

@end
