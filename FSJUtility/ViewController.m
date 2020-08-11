//
//  ViewController.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/7.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *string = @"我们是中国人,mydkalkdk";
    NSInteger count = [string fsj_numberOfBytes];
    NSLog(@"count : %ld",(long)count);
    
    NSString *str = [string fsj_stringAtIndexWithByteCount:5];
    NSLog(@"str >>> %@",str);
    str = [string fsj_stringAtIndexWithByteCount:10];
    NSLog(@"str >>> %@",str);
    str = [string fsj_stringAtIndexWithByteCount:11];
    NSLog(@"str >>> %@",str);
    str = [string fsj_stringAtIndexWithByteCount:12];
    NSLog(@"str >>> %@",str);
    str = [string fsj_stringAtIndexWithByteCount:15];
    NSLog(@"str >>> %@",str);
}


@end
