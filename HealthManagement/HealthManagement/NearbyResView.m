//
//  NearbyResView.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/10.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "NearbyResView.h"
#import "NearbyRestaurantVC.h"

@implementation NearbyResView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((kScreen_Width-80)/2, 15, 80, 20)];
    lab.font = [UIFont systemFontOfSize:18];
    lab.text = @"附近餐厅";
    lab.textAlignment = NSTextAlignmentCenter;
//    lab.backgroundColor = [UIColor cyanColor];
//    lab.textColor = [UIColor colorWithHexString:@"#868788"];
    [self addSubview:lab];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(lab.left-12-50, lab.center.y, 50, 1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#B9C9B9"];
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(lab.right+12, lab.center.y, 50, 1)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#B9C9B9"];
    [self addSubview:line2];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreen_Width-50, 0, 50, 50);
    [btn setImage:[UIImage imageNamed:@"assistor"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
//    btn.backgroundColor = [UIColor redColor];
    [self addSubview:btn];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, btn.bottom, kScreen_Width, kWidth+10+20)];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(kScreen_Width*3, kWidth+10+20);
    [self addSubview:scrollView];
    
    for (int i=0; i<3; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*kScreen_Width, 0, kScreen_Width, scrollView.height)];
        [scrollView addSubview:view];
        
        for (int j=0; j<3; j++) {
            
            UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(12+j*(kWidth+10), 0, kWidth, scrollView.height)];
            [view addSubview:subView];

            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kWidth)];
//            imgView.backgroundColor = [UIColor redColor];
            imgView.image = [UIImage imageNamed:@"food"];
            imgView.tag = 100+j;
            imgView.layer.cornerRadius = 5;
            imgView.layer.masksToBounds = YES;
            [subView addSubview:imgView];
            
            UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(imgView.left, imgView.bottom+10, kWidth*2/3, 16)];
            moneyLab.font = [UIFont systemFontOfSize:14];
            //        moneyLab.textAlignment = NSTextAlignmentRight;
            moneyLab.text = @"星巴克";
            //        moneyLab.textColor = [UIColor redColor];
//            moneyLab.backgroundColor = [UIColor yellowColor];
            moneyLab.tag = 101+j;
            [subView addSubview:moneyLab];
            
            UILabel *fitLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-kWidth/3, imgView.bottom+12, kWidth/3, 14)];
            fitLab.font = [UIFont systemFontOfSize:12];
            fitLab.textAlignment = NSTextAlignmentRight;
            fitLab.text = @"120m";
            fitLab.tag = 102+j;
            fitLab.textColor = [UIColor grayColor];
            //        fitLab.backgroundColor = [UIColor yellowColor];
            [subView addSubview:fitLab];
        }

        
        [_viewArr addObject:view];
        
    }
    
    // 添加pageControl
    UIPageControl * pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake((kScreen_Width-20)/2, scrollView.bottom+10, 20, 20);
    pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#B8B9BA"];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#59A43A"];
    pageControl.hidesForSinglePage = YES;
    pageControl.numberOfPages = 3;
    pageControl.currentPage = 0;
    _pageControl = pageControl;
    [self addSubview:_pageControl];
    
    self.height = _pageControl.bottom+10;
}

// 跳转附近餐厅
- (void)btnAction
{
    NearbyRestaurantVC *vc = [[NearbyRestaurantVC alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (void)setModelArr:(NSArray *)modelArr
{
    _modelArr = modelArr;
    
    for (int i=0; i<_viewArr.count; i++) {
        UIView *view = _viewArr[i];
        
        for (int j=0; j<view.subviews.count; j++) {
            
//            UIView *subView = view.subviews[j];
//            UIImageView *imgView = (UIImageView *)[subView viewWithTag:100+j];
//            UILabel *titleLab = (UILabel *)[subView viewWithTag:101+j];
//            UILabel *moneyLab = (UILabel *)[subView viewWithTag:102+j];
        }

//        NSLog(@"%@",view.subviews);
    }
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.x);
    _pageControl.currentPage = scrollView.contentOffset.x/kScreen_Width;
}


@end
