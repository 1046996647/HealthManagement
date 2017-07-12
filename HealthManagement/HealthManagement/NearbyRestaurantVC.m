//
//  NearbyRestaurantVC.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/11.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "NearbyRestaurantVC.h"
#import "NearbyRestaurantTableView.h"
#import "RecommendDietTableView.h"

@interface NearbyRestaurantVC ()

@property(nonatomic,strong) UIButton *nearbyBtn;
@property(nonatomic,strong) UIButton *recommendBtn;
@property(nonatomic,strong) UIView *bottomLine;
@property(nonatomic,strong) UIScrollView *scrollView;


@property(nonatomic,strong) NearbyRestaurantTableView *nearbyRestaurantTableView;
@property(nonatomic,strong) RecommendDietTableView *recommendDietTableView;


@end

@implementation NearbyRestaurantVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"附近餐厅";
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 3, kScreen_Width, 50)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    // 附近餐厅按钮
    _nearbyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nearbyBtn.frame = CGRectMake(0, baseView.top, kScreen_Width/2.0, 50);
    [_nearbyBtn setImage:[UIImage imageNamed:@"home_3"] forState:UIControlStateNormal];
    [_nearbyBtn setImage:[UIImage imageNamed:@"Restaurant_1"] forState:UIControlStateSelected];
    //    _nearbyBtn.backgroundColor = [UIColor redColor];
    _nearbyBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    _nearbyBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    _nearbyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_nearbyBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_nearbyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    _nearbyBtn.tag = 100;
    [_nearbyBtn setTitle:@"附近餐厅" forState:UIControlStateNormal];
    [_nearbyBtn addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];
    _nearbyBtn.selected = YES;
    [self.view addSubview:_nearbyBtn];
    
    // 推荐饮食按钮
    _recommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommendBtn.frame = CGRectMake(kScreen_Width/2.0, baseView.top, kScreen_Width/2.0, 50);
    [_recommendBtn setImage:[UIImage imageNamed:@"Restaurant_2"] forState:UIControlStateNormal];
    [_recommendBtn setImage:[UIImage imageNamed:@"home_3"] forState:UIControlStateSelected];
    //    _nearbyBtn.backgroundColor = [UIColor redColor];
    //    _btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    _recommendBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_recommendBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_recommendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    _recommendBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -8, 0, 0);
    _recommendBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -8);
    //    _recommendBtn.selected = YES;
    _recommendBtn.tag = 101;
    [_recommendBtn setTitle:@"推荐饮食" forState:UIControlStateNormal];
    [_recommendBtn addTarget:self action:@selector(exchangeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_recommendBtn];
    
    // 底线
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, _recommendBtn.bottom, kScreen_Width/2.0, 3)];
    _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#EA3D00"];
    [self.view addSubview:_bottomLine];
    
    // 滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _bottomLine.bottom, kScreen_Width, kScreen_Height-64-_bottomLine.bottom)];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(kScreen_Width*2, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 附近餐厅视图
    _nearbyRestaurantTableView = [[NearbyRestaurantTableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-_bottomLine.bottom)];
//    baseView.backgroundColor = [UIColor whiteColor];
    
    // 推荐饮食视图
    _recommendDietTableView = [[RecommendDietTableView alloc] initWithFrame:CGRectMake(kScreen_Width, 0, kScreen_Width, kScreen_Height-64-_bottomLine.bottom)];
    //    baseView.backgroundColor = [UIColor whiteColor];
//    _recommendDietTableView.hidden = YES;
    
    [scrollView addSubview:_nearbyRestaurantTableView];
    [scrollView addSubview:_recommendDietTableView];

    // 搜索按钮
    [self initRightItem];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

// 搜索按钮
- (void)initRightItem
{
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 20, 20);
    [btn2 addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//    [btn2 setTitle:@"缴费记录" forState:UIControlStateNormal];
//    btn2.titleLabel.font = [UIFont systemFontOfSize:15];
//    [btn2 setTitleColor:[UIColor colorWithHexString:@"#0D60FA"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
}

// 搜索
- (void)searchAction
{
    
}

- (void)exchangeAction:(UIButton *)btn
{
    if (btn.tag == 100) {
//        _nearbyBtn.selected = YES;
//        _recommendBtn.selected = NO;
        
        [UIView animateWithDuration:.35 animations:^{
            _bottomLine.left = 0;
            self.scrollView.contentOffset = CGPointMake(0, 0);

        }];
        
    }
    else {
//        _nearbyBtn.selected = NO;
//        _recommendBtn.selected = YES;
        
        [UIView animateWithDuration:.35 animations:^{
            _bottomLine.left = kScreen_Width/2;

            self.scrollView.contentOffset = CGPointMake(kScreen_Width, 0);

        }];

    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    _bottomLine.left = scrollView.contentOffset.x/kScreen_Width;
//    NSLog(@"%d",(int)scrollView.contentOffset.x);
    if ((int)scrollView.contentOffset.x/kScreen_Width == 0) {
        
        //        _nearbyBtn.selected = YES;
        //        _recommendBtn.selected = NO;
        [UIView animateWithDuration:.35 animations:^{
            _bottomLine.left = 0;
            
        }];
        
    }
    else if ((int)scrollView.contentOffset.x/kScreen_Width == 1) {
        
        //        _nearbyBtn.selected = NO;
        //        _recommendBtn.selected = YES;
        [UIView animateWithDuration:.35 animations:^{
            _bottomLine.left = kScreen_Width/2;
            
        }];
        
    }
}




@end
