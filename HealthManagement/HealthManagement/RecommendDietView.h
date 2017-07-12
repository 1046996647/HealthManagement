//
//  RecommendDietView.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/7/10.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendDietView : UIView

#define kBigWidth 120*scaleX

#define kWidth (kScreen_Width-12*2-5*2-kBigWidth)/2.0

@property(nonatomic,strong) NSMutableArray *viewArr;
@property(nonatomic,strong) NSArray *modelArr;

@property(nonatomic,strong) UIView *bigView;


@end
