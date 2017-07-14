//
//  HeaderView.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/10.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "NearbyResView.h"
#import "RecommendDietView.h"
#import "DietRecordView.h"


@interface HeaderView : UIView<SDCycleScrollViewDelegate>

//-----------定位-----------
@property(nonatomic,strong) UILabel *userLocationLab;

//-----------搜索-----------
@property(nonatomic,strong) UITextField *tf;



//-----------轮播-----------
@property(nonatomic,strong) SDCycleScrollView *cycleScrollView2;

//----------------------
@property(nonatomic,strong) UIButton *btn;
@property(nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UIImageView *imgView1;
@property(nonatomic,strong) UIButton *btn1;

//-----------附近餐厅-----------
@property(nonatomic,strong) NearbyResView *nearbyResView;

//-----------推荐饮食-----------
@property(nonatomic,strong) RecommendDietView *recommendDietView;

//-----------饮食记录-----------
@property(nonatomic,strong) DietRecordView *dietRecordView;

// 饮食记录
@property(nonatomic,strong) UIView *dietView;


@end