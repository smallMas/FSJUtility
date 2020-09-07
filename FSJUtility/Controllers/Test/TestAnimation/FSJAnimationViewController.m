//
//  FSJAnimationViewController.m
//  FSJUtility
//
//  Created by 燕来秋 on 2020/9/4.
//  Copyright © 2020 燕来秋. All rights reserved.
//

#import "FSJAnimationViewController.h"
#import "FSJMenuModel.h"

@interface FSJAnimationViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@end

@implementation FSJAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"测试动画";
    
    if (self.animationType == FSJAnimationTypeTransitions) {
        [self initTransitionsData];
        
        [self.view addSubview:self.collectionView];
        
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(100);
        }];
        
        FSJ_WEAK_SELF
        self.collectionView.collectionViewDidSelectItemAtIndexPathBlock = ^(UICollectionView *collectionView, NSIndexPath *indexPath, id itemData) {
            FSJ_STRONG_SELF
            FSJMenuModel *model = itemData;
            [self.centerView fsj_transitionAnimationType:model.type subType:FSJTransitionSubTypeLeft];
        };
    }
    
    [self.view addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self testAnimation];
    });
}

- (void)initTransitionsData {
    [self.dataArray addObject:[FSJMenuModel createMenuType:FSJTransitionTypeFade title:@"淡入淡出" size:CGSizeMake(100, 100)]];
    [self.dataArray addObject:[FSJMenuModel createMenuType:FSJTransitionTypePush title:@"推挤" size:CGSizeMake(100, 100)]];
    [self.dataArray addObject:[FSJMenuModel createMenuType:FSJTransitionTypeReveal title:@"揭开" size:CGSizeMake(100, 100)]];
    [self.dataArray addObject:[FSJMenuModel createMenuType:FSJTransitionTypeMoveIn title:@"覆盖" size:CGSizeMake(100, 100)]];
    [self.dataArray addObject:[FSJMenuModel createMenuType:FSJTransitionTypeCube title:@"立方体" size:CGSizeMake(100, 100)]];
    [self.dataArray addObject:[FSJMenuModel createMenuType:FSJTransitionTypeSuckEffect title:@"吮吸" size:CGSizeMake(100, 100)]];
    [self.dataArray addObject:[FSJMenuModel createMenuType:FSJTransitionTypeOglFlip title:@"翻转" size:CGSizeMake(100, 100)]];
    [self.dataArray addObject:[FSJMenuModel createMenuType:FSJTransitionTypeRippleEffect title:@"波纹" size:CGSizeMake(100, 100)]];
    [self.dataArray addObject:[FSJMenuModel createMenuType:FSJTransitionTypePageCurl title:@"翻页" size:CGSizeMake(100, 100)]];
    [self.dataArray addObject:[FSJMenuModel createMenuType:FSJTransitionTypePageUnCurl title:@"反翻页" size:CGSizeMake(100, 100)]];
    [self.dataArray addObject:[FSJMenuModel createMenuType:FSJTransitionTypeCameraIrisHollowOpen title:@"开镜头" size:CGSizeMake(100, 100)]];
    [self.dataArray addObject:[FSJMenuModel createMenuType:FSJTransitionTypeCameraIrisHollowClose title:@"关镜头" size:CGSizeMake(100, 100)]];
    
    [self reloadData];
}

- (void)reloadData {
    self.collectionView.cellDatas = @[self.dataArray];
    [self.collectionView reloadData];
}

#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [UIView new];
        [_centerView setBackgroundColor:[UIColor fsj_randomColor]];
    }
    return _centerView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.fsj_width, 100) collectionViewLayout:self.layout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        // cell的行边距[ = ](上下边距)
        _layout.minimumLineSpacing = 5.0f;
        // cell的纵边距[ || ](左右边距)
        _layout.minimumInteritemSpacing = 0.0f;
        [_layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    }
    return _layout;
}

#pragma mark - 内部方法
- (void)testAnimation {
    switch (self.animationType) {
        case FSJAnimationTypeScale1:
        {
            [self.centerView fsj_startScaleAnimationFinishBlock:^{
                
            }];
        }
            break;
        case FSJAnimationTypeScale2:
        {
            [self.centerView fsj_startScaleAnimation];
        }
            break;
        case FSJAnimationTypeRotation1:
        {
            [self.centerView fsj_rotationDuration:0.25 from:0 to:M_PI*2];
        }
            break;
        case FSJAnimationTypeRotation2:
        {
            [self.centerView fsj_rotationDuration:0.25 from:0 to:M_PI*2 repeatCount:10];
        }
            break;
        case FSJAnimationTypeOpacity:
        {
            [self.centerView fsj_opacityAnimation];
        }
            break;
            
        case FSJAnimationTypeOther:
        {
            [self testOther];
        }
            break;
        default:
            break;
    }
}

- (void)testOther {
    NSLog(@"%s",__FUNCTION__);
    //- 创建一个转场动画:
    CATransition *transition = [CATransition animation];
    transition.repeatCount = 1;
    //    - 确定动画类型:
    transition.type = @"cameraIrisHollowOpen";
    //    - 确定子类型(方向等)
//    transition.subtype = kCATransitionFromLeft;
    //    - 确定动画时间
    transition.duration = 0.5;
    
    [transition setFillMode:kCAFillModeForwards];
    
    // 设置运动速度
//    transition.timingFunction = UIViewAnimationCurveEaseInOut;
    
    //    - 添加动画
    [self.view.layer addAnimation:transition forKey:nil];
}

@end
