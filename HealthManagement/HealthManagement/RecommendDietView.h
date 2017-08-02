//
//  RecommendDietView.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/10.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipeModel.h"


@interface RecommendDietView : UIView

#define kBigWidth 120*scaleWidth

#define kRWidth (kScreen_Width-12*2-(16*scaleWidth)*2-kBigWidth)/2.0

@property(nonatomic,strong) NSMutableArray *viewArr;
@property(nonatomic,strong) NSMutableArray *modelArr;

@property(nonatomic,assign) NSInteger pageNO;// 页数

@property(nonatomic,strong) NSNumber *latitude;// 纬度
@property(nonatomic,strong) NSNumber *longitude;// 经度

@property(nonatomic,strong) UIView *bigView;


@end
