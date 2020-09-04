//
//  FSJMainViewController.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/8/12.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJMainViewController.h"
#import "FSJMenuModel.h"
#import "FSJPopBottomContainerView.h"
#import "FSJMenuTableView.h"

typedef NS_ENUM(NSInteger, FSJMenuType) {
    FSJMenuTypeTestString,
    FSJMenuTypeTestBottom,
    FSJMenuTypeTestTabContain,
    FSJMenuTypeTestArea,
    FSJMenuTypeTestTask,
    FSJMenuTypeTestAnimation,
};

@interface FSJMainViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation FSJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupData];
    self.tableView.tableViewAdapter.headerHeight = 0.0001;
    self.tableView.tableViewAdapter.footerHeight = 0.0001;
    [self.view addSubview:self.tableView];
    [self reloadData];
    
    FSJ_WEAK_SELF
    self.tableView.tableViewDidSelectRowBlock = ^(UITableView *tableView, NSIndexPath *indexPath, id itemData) {
        FSJ_STRONG_SELF
        FSJMenuModel *model = itemData;
        if (model.vcString) {
            Class cls = NSClassFromString(model.vcString);
            UIViewController *vc = [cls new];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            switch (model.type) {
                case FSJMenuTypeTestString:
                    [self testString];
                    break;
                    
                case FSJMenuTypeTestBottom:
                    [self testBottom];
                    break;
                    
                default:
                    break;
            }
        }
    };
}

- (void)setupData {
    [self.dataArray addObject:[self createMenuType:FSJMenuTypeTestString title:@"测试字符串" clsString:nil]];
    [self.dataArray addObject:[self createMenuType:FSJMenuTypeTestBottom title:@"测试底部弹框" clsString:nil]];
    [self.dataArray addObject:[self createMenuType:FSJMenuTypeTestTabContain title:@"测试TabContain" clsString:@"TestTabContainViewController"]];
    [self.dataArray addObject:[self createMenuType:FSJMenuTypeTestArea title:@"测试view点击区域" clsString:@"TestClickAreaController"]];
    [self.dataArray addObject:[self createMenuType:FSJMenuTypeTestTask title:@"测试任务" clsString:@"FSJTestTaskController"]];
    [self.dataArray addObject:[self createMenuType:FSJMenuTypeTestAnimation title:@"测试动画" clsString:@"FSJTestAnimationController"]];
}

- (FSJMenuModel *)createMenuType:(FSJMenuType)type title:(NSString *)title clsString:(NSString *)clsString {
    NSString *text = title;
    FSJMenuModel *model = [FSJMenuModel new];
    model.type = type;
    model.text = text;
    model.vcString = clsString;
    return model;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)reloadData {
    self.tableView.cellDatas = @[self.dataArray];
    [self.tableView reloadData];
}

#pragma mark - test
- (void)testString {
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
    
    string = @"我们的百度http://www.baidu.com棒棒的";
    NSArray *arr = [string fsj_matchUrl];
    NSLog(@"arr >>> %@",arr);
}

- (void)testBottom {
    FSJMenuTableView *view = [[FSJMenuTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.fsj_width, 200)];
    [view setBgColor:[UIColor fsj_randomColor]];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:[self createMenuType:FSJMenuTypeTestString title:@"test1" clsString:nil]];
    [array addObject:[self createMenuType:FSJMenuTypeTestBottom title:@"test2" clsString:nil]];
    [view setDataArray:array];
    view.eventTransmissionBlock = ^id(id target, id params, NSInteger tag, CHGCallBack callBack) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kFSJPopBottomCloseDoneNoAnimationPressed object:nil];
        if (tag == 0) {
            FSJAlertSheetView *sheetView = [[FSJAlertSheetView alloc] initWithTitle:@"test" message:@"test sheet" style:UIAlertControllerStyleActionSheet cancelButtonTitle:@"取消" otherButtonTitles:@"tap1", nil];
            [sheetView setActionStyle:UIAlertActionStyleDestructive index:0];
            [sheetView show:^(NSInteger index) {
                NSLog(@"index >>> %ld",(long)index);
            }];
        }else {
            [self testBottom];
        }
        return nil;
    };
    
    UIView *superView = [UIApplication sharedApplication].keyWindow;
    FSJPopBottomContainerView *bottomView = [[FSJPopBottomContainerView alloc] initWithSuperView:superView withView:view];
    bottomView.backViewColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    bottomView.showNumY = @((superView.bounds.size.height - view.bounds.size.height)*0.5);
    bottomView.hiddenNumY = @(-view.bounds.size.height);
    
//    __weak typeof (bottomView) wBottomView = bottomView;
//    CGSize originalSize = view.bounds.size;
//    [bottomView setShowAnimationBlock:^(FSJVoidBlock  _Nonnull block) {
//        CGSize size = CGSizeMake(100, 100);
//        CGRect rect1 = wBottomView.superview.frame;
//        rect1.size = size;
//        rect1.origin.x = (superView.bounds.size.width - size.width)*0.5;
//        rect1.origin.y = (superView.bounds.size.height - size.height)*0.5;
//        [wBottomView.subView setFrame:rect1];
//
//        NSLog(@"rect1 >>> %@",NSStringFromCGRect(rect1));
//
//        [UIView animateWithDuration:01.25 animations:^{
//            NSLog(@"--------1");
//            CGRect rect2 = wBottomView.superview.frame;
//            rect2.size = originalSize;
//            rect2.origin.x = (superView.bounds.size.width - originalSize.width)*0.5;
//            rect2.origin.y = (superView.bounds.size.height - originalSize.height)*0.5;
//            [wBottomView.subView setFrame:rect2];
//        } completion:^(BOOL finished) {
//            NSLog(@"--------2");
//            if (block) {
//                block();
//            }
//        }];
//    }];
//
//    [bottomView setHiddenAnimationBlock:^(FSJVoidBlock  _Nonnull block) {
//        block();
//    }];
    [bottomView show:YES];
}

@end
