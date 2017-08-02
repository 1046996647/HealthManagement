//
//  NearbyResView.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/10.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResDetailModel.h"

#define kWidth (kScreen_Width-12*2-10*2)/3.0


@interface NearbyResView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong) NSMutableArray *viewArr;
@property(nonatomic,strong) NSMutableArray *modelArr;
@property(nonatomic,assign) NSInteger pageNO;// 页数

@property(nonatomic,strong) NSNumber *latitude;// 纬度
@property(nonatomic,strong) NSNumber *longitude;// 经度
@property(nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl * pageControl;


@end
