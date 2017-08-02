//
//  ClockView.h
//  HealthManagement
//
//  Created by ZhangWeiLiang on 2017/8/2.
//  Copyright © 2017年 ZhangWeiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClockBlock)(void);


@interface ClockView : UIView

@property (nonatomic,strong) UILabel *sleepLab2;
@property (nonatomic,copy) NSString *timeStr;

@property (nonatomic,copy) ClockBlock block;


@end
