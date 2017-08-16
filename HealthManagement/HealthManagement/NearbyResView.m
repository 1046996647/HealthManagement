//
//  NearbyResView.m
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/10.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import "NearbyResView.h"
#import "NearbyRestaurantVC.h"
#import "NSStringExt.h"
#import "ResDetailVC.h"

@implementation NearbyResView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self initSubViews];
        
        self.viewArr = [NSMutableArray array];
    }
    return self;
}

- (void)initSubViews
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((kScreen_Width-80)/2, 15, 80, 20)];
    lab.font = [UIFont systemFontOfSize:16];
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
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加pageControl
    UIPageControl * pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake((kScreen_Width-20)/2, self.scrollView.bottom+10, 20, 20);
    pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#B8B9BA"];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#59A43A"];
    pageControl.hidesForSinglePage = YES;
    pageControl.currentPage = 0;
    _pageControl = pageControl;
    [self addSubview:_pageControl];
    
    self.height = _pageControl.bottom+10;
    
}

// 跳转附近餐厅
- (void)btnAction
{
    NearbyRestaurantVC *vc = [[NearbyRestaurantVC alloc] init];
    vc.latitude = self.latitude;
    vc.longitude = self.longitude;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (void)setModelArr:(NSMutableArray *)modelArr
{
    _modelArr = modelArr;
    
    // 移除之前添加的视图
    if (_viewArr.count>0) {
        for (UIView *view in _viewArr) {
            for (UIView *view1 in view.subviews) {
                [view1 removeFromSuperview];
            }
        }
    }

    NSInteger pageCount = modelArr.count / 3;
    if (modelArr.count % 3 > 0) {
        pageCount += 1;
        
        if (pageCount > 3) {
            pageCount = 3;
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(kScreen_Width*pageCount,0);
    self.pageControl.numberOfPages = pageCount;
    
    NSInteger index = 0;
    for (int i=0; i<pageCount; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*kScreen_Width, 0, kScreen_Width, self.scrollView.height)];
        [self.scrollView addSubview:view];
        
        for (int j=0; j<3; j++) {
            
            if (index < modelArr.count) {// 控制个数
                ResDetailModel *model = modelArr[index];
                
                UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(12+j*(kWidth+10), 0, kWidth, self.scrollView.height)];
                [view addSubview:subView];
                
                UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kWidth)];
                //            imgView.backgroundColor = [UIColor redColor];
                [imgView sd_setImageWithURL:[NSURL URLWithString:model.titleImage]];
                //            imgView.image = [UIImage imageNamed:@"food"];
                imgView.tag = index;
                imgView.layer.cornerRadius = 5;
                imgView.layer.masksToBounds = YES;
                imgView.userInteractionEnabled = YES;
                imgView.clipsToBounds = YES;
                imgView.contentMode = UIViewContentModeScaleAspectFill;
                [subView addSubview:imgView];
                
                // 手势
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                [imgView addGestureRecognizer:tap];
                
                UILabel *moneyLab = [[UILabel alloc] initWithFrame:CGRectMake(imgView.left, imgView.bottom+10, kWidth*2/3-5, 16)];
                moneyLab.font = [UIFont systemFontOfSize:12];
                //        moneyLab.textAlignment = NSTextAlignmentRight;
                moneyLab.text = model.name;
                //        moneyLab.textColor = [UIColor redColor];
                //            moneyLab.backgroundColor = [UIColor yellowColor];
                moneyLab.tag = 101+j;
                [subView addSubview:moneyLab];
                
                UILabel *fitLab = [[UILabel alloc] initWithFrame:CGRectMake(kWidth-kWidth/3-5, imgView.bottom+12, kWidth/3+5, 14)];
                fitLab.font = [UIFont systemFontOfSize:11];
                fitLab.textAlignment = NSTextAlignmentRight;
                fitLab.text = [NSString meterToKilometer:model.distance];
                fitLab.tag = 102+j;
                fitLab.textColor = [UIColor grayColor];
                //        fitLab.backgroundColor = [UIColor yellowColor];
                [subView addSubview:fitLab];
            }
            index++;
        }
        
        
        [_viewArr addObject:view];
        
    }
    
    
}

- (void)tapAction:(UIGestureRecognizer *)tap
{
    NSInteger index = tap.view.tag;
    ResDetailModel *model = _modelArr[index];

    ResDetailVC *vc = [[ResDetailVC alloc] init];
    vc.resID = model.ID;
    vc.latitude = self.latitude;
    vc.longitude = self.longitude;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%f",scrollView.contentOffset.x);
    _pageControl.currentPage = scrollView.contentOffset.x/kScreen_Width;
}


@end
